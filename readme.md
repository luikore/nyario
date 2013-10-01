# nyario

- Fiber-based high performance IO lib.
- Provides event-free API on top of kqueue(2) or epoll(2).
- It's not fiber-layer-over-event-callback, it's fiber from the bottom up.

# background

The basic idea is connections are multiplexed with Fiber.
System events are edge triggered, and the loop mixes a resource-sweeping round once in a while.
The representation of connection is highly optimized for CRuby.
