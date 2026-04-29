PROJECT_PATH ?= $(PWD)

help:
	@echo ""
	@echo "Available commands:"
	@echo "\tmake help"
	@echo "\tmake show"
	@echo "\tmake cache:clear"
	@echo "\tmake run QUERY=\"text\" #Optional PROJECTS=\"project1,project2\""
	@echo ""

run:
	@if [ -z "$(QUERY)" ]; then \
		echo "Error: Proper use -> make gitlab-search QUERY=\"text\" PROJECTS=\"project1,project2\" #Optional "; \
		exit 1; \
	fi

	@chmod 777 var/cache var/results
	docker compose run --rm gitlab-searcher "$(QUERY)" $(if $(PROJECTS),"$(PROJECTS)")

show:
	/bin/less var/results/search_results.txt

cache\:clear:
	rm -f var/cache/projects_cache.json
