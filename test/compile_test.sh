#!/usr/bin/env sh

. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh

testCompile() {
	printf '[edgedb]\nserver-version = "1.1"\n' > ${BUILD_DIR}/edgedb.toml

	compile
	assertCapturedSuccess
	assertCaptured "Vendoring jq into slug"
	assertCaptured "Installed jq-1.6"
	assertCaptured "Vendoring EdgeDB CLI into slug"
	assertCaptured "Installed EdgeDB CLI 1.1"
	assertCaptured "Vendoring edgedb-server into slug"
	assertCaptured "Installed edgedb-server, version 1.1"

	capture ${BUILD_DIR}/bin/edgedb --version
	assertCapturedSuccess
	assertCaptured "EdgeDB CLI 1.1"

	capture ${BUILD_DIR}/bin/edgedb-server --version
	assertCapturedSuccess
	assertCaptured "edgedb-server, version 1.1"

	capture ${BUILD_DIR}/bin/jq --version
	assertCapturedSuccess
	assertCaptured "jq-1.6"
}
