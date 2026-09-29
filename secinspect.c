#define _DEFAULT_SOURCE // for S_ISSOCK
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

#define BUFFER_SIZE 4096
int main(int argc, char* argv[])
{
	char buffer[BUFFER_SIZE + 1]; // extra byte for '\0'
	if (argc != 3)
	{
		puts("Usage: secinspect {-r|-w|-wa|-i} <filepath>\n");
		return 1;
	}

	int is_read        = (strcmp(argv[1], "-r") == 0);
	int is_write       = (strcmp(argv[1], "-w") == 0);
	int is_w_append    = (strcmp(argv[1], "-wa") == 0);
	int is_interactive = (strcmp(argv[1], "-i") == 0);

	if (!is_read && !is_write && !is_w_append && !is_interactive)
	{
		fprintf(stderr, "Usage: ./secinspect {-r|-w|-wa|-i} <filepath>\n");
		return 1;
	}
	int fd = -1;

	// -wa writes in append mode
	if (is_write || is_w_append)
	{
		fd = is_w_append ? open(argv[2], O_WRONLY | O_APPEND) : open(argv[2], O_WRONLY | O_CREAT | O_TRUNC, 0644);
	}
	if (is_read) fd = open(argv[2], O_RDONLY);
	if (is_interactive) fd = open(argv[2], O_RDWR);

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
	else if (is_write || is_w_append)
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
	else if (is_interactive)
	{
		int opt = -1;
		puts("secinspect utility interactive mode");
		printf("1. fstat %s\n2. read starting at some offset\nopt: ", argv[2]);
		if (scanf("%d", &opt) != 1)
		{
			fprintf(stderr, "input error");
			close(fd);
			return 1;
		}
		switch (opt)
		{
		case 1:
		{
			struct stat st;
			if (fstat(fd, &st) == -1)
			{
				perror("fstat");
				break;
			}

			printf("size:      %lld bytes\n", (long long)st.st_size);
			printf("inode:     %llu\n", (unsigned long long)st.st_ino);
			printf("links:     %llu\n", (unsigned long long)st.st_nlink);
			printf("uid:       %u\n", st.st_uid);
			printf("gid:       %u\n", st.st_gid);

			if (S_ISREG(st.st_mode))
				puts("type:      regular file");
			else if (S_ISDIR(st.st_mode))
				puts("type:      directory");
			else if (S_ISCHR(st.st_mode))
				puts("type:      character device");
			else if (S_ISBLK(st.st_mode))
				puts("type:      block device");
			else if (S_ISFIFO(st.st_mode))
				puts("type:      FIFO/pipe");
			else if (S_ISLNK(st.st_mode))
				puts("type:      symlink");
			else if (S_ISSOCK(st.st_mode))
				puts("type:      socket");
			else
				puts("type:      unknown");

			printf("perms:     %c%c%c%c%c%c%c%c%c\n", (st.st_mode & S_IRUSR) ? 'r' : '-', (st.st_mode & S_IWUSR) ? 'w' : '-',
			       (st.st_mode & S_IXUSR) ? 'x' : '-', (st.st_mode & S_IRGRP) ? 'r' : '-', (st.st_mode & S_IWGRP) ? 'w' : '-',
			       (st.st_mode & S_IXGRP) ? 'x' : '-', (st.st_mode & S_IROTH) ? 'r' : '-', (st.st_mode & S_IWOTH) ? 'w' : '-',
			       (st.st_mode & S_IXOTH) ? 'x' : '-');
			break;
		}
		case 2:
		{
			long long offset_in = 0;

			off_t size = lseek(fd, 0, SEEK_END);
			if (size < 0)
			{
				perror("lseek");
				close(fd);
				return 1;
			}
			printf("Enter a read starting offset in bytes (the start is the beginning of the file)\n The file is %ld "
			       "bytes.\noffset> ",
			       size);
			off_t pos = lseek(fd, 0, SEEK_SET); // jump to begining
			if (pos < 0)
			{
				perror("lseek");
				close(fd);
				return 1;
			}

			if (scanf("%lld", &offset_in) != 1)
			{
				fprintf(stderr, "input error");
				return 1;
			}

			pos = lseek(fd, (off_t)offset_in, SEEK_SET); // offset_in bytes from begining of file
			if (pos < 0)
			{
				perror("lseek");
				close(fd);
				return 1;
			}

			ssize_t bytes = read(fd, buffer, BUFFER_SIZE);
			if (bytes < 0)
			{
				perror("read");
				close(fd);
				return 1;
			}
			buffer[bytes] = '\0'; // null terminate read
			printf("Read %zd bytes from %s.\nDATA:\n%s", bytes, argv[2], buffer);
			break;
		}
		default: return 0;
		}
	}
	if (close(fd) == -1) perror("close");
	return 0;
}
