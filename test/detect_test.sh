#!/usr/bin/env sh

. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh

testDetect() {
	printf '[edgedb]\nserver-version = "1.1"\n' > ${BUILD_DIR}/edgedb.toml
	mkdir -p ${BUILD_DIR}/dbschema/migrations
	touch ${BUILD_DIR}/dbschema/migrations/00001.edgeql

	detect
	assertCapturedSuccess
	assertCaptured "EdgeDB"
}

testDetectNoEdgeDBTOML() {
	mkdir -p ${BUILD_DIR}/dbschema/migrations
	touch ${BUILD_DIR}/dbschema/migrations/00001.edgeql

	detect
	assertCapturedError "EdgeDB on Heroku requires an edgedb.toml file"
}

testDetectNoMigrationsDir() {
	printf '[edgedb]\nserver-version = "1.1"\n' > ${BUILD_DIR}/edgedb.toml

	detect
	assertCapturedError "unable to detect"
	assertCapturedError "migration files"
}

testDetectNoMigrations() {
	printf '[edgedb]\nserver-version = "1.1"\n' > ${BUILD_DIR}/edgedb.toml
	mkdir -p ${BUILD_DIR}/dbschema/migrations

	detect
	assertCapturedError "unable to detect"
	assertCapturedError "migration files"
}
