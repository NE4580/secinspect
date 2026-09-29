# secinspect

A small Linux utility for inspecting and demonstrating low-level file I/O
via the raw Unix system call interface (open, read, write, lseek, close, fstat).

## Usage

    ./secinspect <mode> <filepath>

## Modes

    -r      Open <filepath> read-only. Reads up to 4096 bytes and prints them.
    -w      Open <filepath> for writing. Creates it if missing, truncates it
            if it exists. Reads one line from stdin and writes it to the file
            (trailing newline stripped).
    -wa     Open <filepath> in append mode. Creates it if missing. Reads one
            line from stdin and appends it to the end of the file.
    -i      Open <filepath> read/write and enter interactive mode.
            Interactive options:
              1. fstat — print file metadata (size, inode, links, owner,
                 type, permissions).
              2. seek and read — prompt for a byte offset, seek there,
                 and read up to 4096 bytes from that position.

## Examples

    ./secinspect -r /etc/hostname
    ./secinspect -w notes.txt
    ./secinspect -wa notes.txt
    ./secinspect -i notes.txt

## Notes

- Regular files only. Directories, pipes, and devices are not supported.
- All syscall failures are reported to stderr with the failing operation name.
- Requires a POSIX system (Linux). Built with:

      gcc -Wall -Wextra -std=c11 -o secinspect secinspect.c
