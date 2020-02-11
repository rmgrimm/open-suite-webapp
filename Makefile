######################################################
# This is only intended for LOCAL DEVELOPMENT !!!!!! #
######################################################

start:
	docker run axelor-erp:latest

build:
	./gradlew clean && ./gradlew build \
	&& docker build . -t axelor-erp:latest

local:
	docker run -it -d postgres \
	make build && make start

codeready:
	sed -i -E \
		's#^(db.default.url[[:blank:]]*=[[:blank:]]*).*#\1jdbc:postgresql://axelor-postgres-crw/axelor#' \
		src/main/resources/application.properties && \
		./gradlew clean build && \
		./gradlew run

dev:
	docker pull postgres && \
		docker run -d --rm \
		--name axelor-postgres \
		-e POSTGRES_PASSWORD=axelor \
		-e POSTGRES_DB=axleor \
		-e POSTGRES_USER=axelor \
		-p 5432:5432 postgres && \
		sed -i -E \
		's#^(db.default.url[[:blank:]]*=[[:blank:]]*).*#\1jdbc:postgresql://localhost:5432/axelor#' \
		src/main/resources/application.properties && \
		./gradlew clean build && \
		./gradlew run
