Experimenting with go/clojure style CSP macros in [Hy](https://hylang.org/).

Running [main.hy](./main.hy) produces:

	$ hy main.hy 
	5
	4
	3
	got: half way
	2
	1
	got: goodbye
	done

The numbers are coming from a thread and the "got" messages are coming from main.
