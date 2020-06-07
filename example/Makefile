clean:
	rm -rf dist/*

build: clean
	python -m pip install -r src/requirements.txt -t dist/build
	cp -r src/* dist/build
	cd dist/build; zip -9r ../function.zip *

deploy: build
	terraform apply -auto-approve

destroy:
	terraform destroy