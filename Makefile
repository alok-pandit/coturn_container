build-container:
	podman build . -t coturn_cntnr

reset:
	podman system reset

run-interactive:
	podman stop -a && podman run --rm -ti coturn_cntnr

run-bash:
	podman stop -a && podman run --rm -ti coturn_cntnr /bin/bash

run-detached:
	podman stop -a && podman run --rm -d coturn_cntnr

container-ineractive:
	make build-container && make run-interactive

container-bash:
	make build-container && make run-bash

container-detached:
	make build-container && make run-detached