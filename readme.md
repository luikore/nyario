# NOTE

This repo is obsolete. The main point of event based IO is less memory for concurrent connections, and pay less time in CPU context switching, thus leading to higher performance benchmarks. But in real the heavy computation remains in ORMs like active record, the saved CPU time is insignificant while the implementation requires complex tweaks.

# nyario

- Fiber-based high performance IO lib.
- Provides event-free API on top of kqueue(2) or epoll(2).
- It's not fiber-layer-over-event-callback, it's fiber from the bottom up.

# background

The basic idea is connections are multiplexed with Fiber.
System events are edge triggered, and the loop mixes a resource-sweeping round once in a while.
The representation of connection is highly optimized for CRuby.

# operations

Given a server socket and a handler lambda

    Nyario.register server, alambda
    Nyario.loop

Exposed api:

    Nyario.read
    Nyario.write
    Nyario.sleep

C-side api:

    nyario_read
    nyario_write

# mocking

    connect - register events
    close - do cleanups
    recvfrom, recv, read - loop with 
      recv is recvfrom on connected socket
      read is recv with options 0
      recv raise ENOTSOCK when used on non-socket
    sendto, send, write
      send is sendto on connected socket
      write is send with options 0
      send raise ENOTSOCK when used on non-socket

may be need to mock in the future:

    res_init
    select, poll

# user data design

User data is a pointer to a `struct Conn`, it contains the fd, flags, and the running fiber.

A connection can be: server, accepted, or other client created by `connect(2)`.

- Server is closed when the main loop ends.
- Accepted connection is closed when client disconnects or fiber dies.
- Other client connection is reaped when `close(2)` is called.

The very difficult part would be managing context switching of other client connections. For threaded library, we must tweak them to make a mapping of fiber to threads 1:1.

# states

A table of obj => `Conns`

before poll_reap, an array of pollfds is constructed with the pointer table

a queue of sleeping connections

should quit
