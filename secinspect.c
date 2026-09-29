#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

int main(int argc, char* argv[])
{
	char buffer[512];

	if (argc != 3)
	{
		puts("Usage: secinspect <mode> <filepath>");
		return 1;
	}

	int fd = 1, status = 0;
	if (strcmp(argv[1], "-r") == 0) { fd = open(argv[2], O_RDONLY); }
	if (strcmp(argv[1], "-w") == 0) { fd = open(argv[2], O_WRONLY | O_CREAT | O_TRUNC, 0644); }

	if (fd > -1)
		printf("FILE: %s opened!\n  FD: %d\n", argv[2], fd);
	else
	{
		perror("open");
		return 1;
	}
	if (!strcmp(argv[1], "-r"))
	{
		ssize_t bytes = read(fd, buffer, 512);
		if (bytes < 0) { perror("ERROR"); }
		else
			printf("Read %zd bytes from %s.\nDATA:\n%s", bytes, argv[2], buffer);
	}
	else if (strcmp(argv[1], "-w") == 0)
	{
		printf("Provide data to write into the file\n input> ");
		fgets(buffer, 512, stdin);
		buffer[strcspn(buffer, "\n")] = '\0';

		size_t len    = strlen(buffer);
		ssize_t bytes = 0;
		if (len < 512)
			bytes = write(fd, buffer, len);
		else
			perror("ERROR");

		if (bytes < 0)
			perror("ERROR");
		else
			printf("%zd bytes written to file", bytes);
	}
	else
	{
		puts("Unknown option: try -r or -w");
	}

	if (close(fd) == -1)
		perror("close");
	else
		close(fd);
	return 0;
}
