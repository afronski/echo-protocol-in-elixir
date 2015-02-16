# Echo Protocol in Elixir

## Specification - `RFC 862`

```
This RFC specifies a standard for the ARPA Internet community.  Hosts on
the ARPA Internet that choose to implement an Echo Protocol are expected
to adopt and implement this standard.

A very useful debugging and measurement tool is an echo service.  An
echo service simply sends back to the originating source any data it
receives.

TCP Based Echo Service

   One echo service is defined as a connection based application on TCP.
   A server listens for TCP connections on TCP port 7.  Once a
   connection is established any data received is sent back.  This
   continues until the calling user terminates the connection.
```
