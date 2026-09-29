#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#define BUFFER_SIZE 512
int main(int argc, char* argv[])
{
	char buffer[BUFFER_SIZE + 1]; // extran byte for '\0'

	if (argc != 3)
	{
		puts("Usage: secinspect {-r|-w} <filepath>\n");
		return 1;
	}

	int is_read  = (strcmp(argv[1], "-r") == 0);
	int is_write = (strcmp(argv[1], "-w") == 0);
	if (!is_read && !is_write)
	{
		fprintf(stderr, "Usage: secinspect {-r|-w} <filepath>\n");
		return 1;
	}

	int fd = is_read ? open(argv[2], O_RDONLY) : open(argv[2], O_WRONLY | O_CREAT | O_TRUNC, 0644);

	if (fd < 0)
	{
		perror("open");
		return 1;
	}
	printf("FILE: %s opened!\n  FD: %d\n", argv[2], fd);

	if (is_read)
	{
		ssize_t bytes = read(fd, buffer, BUFFER_SIZE);
		if (bytes < 0)
		{
			perror("read");
			close(fd);
			return 1;
		}
		else
		{
			buffer[bytes] = '\0'; // null terminate read
			printf("Read %zd bytes from %s.\nDATA:\n%s", bytes, argv[2], buffer);
		}
	}
	else if (is_write)
	{
		printf("Write upto %d bytes of data to file. trailing '\\n' will be stripped\n input> ", BUFFER_SIZE);
		if (fgets(buffer, BUFFER_SIZE + 1, stdin) == NULL)
		{
			fprintf(stderr, "input error!\n");
			close(fd);
			return 1;
		}
		buffer[strcspn(buffer, "\n")] = '\0'; // strip the \n from fgets

		size_t len    = strlen(buffer);
		ssize_t bytes = write(fd, buffer, len);

		if (bytes < 0)
			perror("write");
		else
			printf("%zd bytes written to file", bytes);
	}

	if (close(fd) == -1) perror("close");
	return 0;
}
