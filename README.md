# Gitlab Searcher (aka the tool)

Docker-based tool for performing text searches across GitLab repositories.

## Prerequisites

    Docker and Docker Compose

    **(Optional) Make (available on Linux, macOS, and WSL)**

## Initial Setup

1. Ensure your .env file is configured with the necessary GitLab API credentials.

2. Var directories are managed automatically but require write permissions.
But if your are using make to run the tool, it takes care of if for you. Otherwise:

   ```
   chmod 777 var/cache var/results
   ```

#### Creating a GitLab Token

1. Go to your GitLab profile → Preferences → Access -> Personal access tokens
2. Create a token with these scopes:
    - `read_api` - Access to `/projects` and `/search` API routes
    - `read_repository` - Access to repository content
3. Copy the `.env.dist` file and name it `.env`.
4. Copy the generated token to your `.env` file

**IMPORTANT:** Never commit `.env` to version control. The file is already in `.gitignore`.

## Usage with Make

Recommended for Linux, macOS, or Windows environments using WSL/Git Bash.

#### List of all commands

| Make command                                                        | Description                                                                              |
|---------------------------------------------------------------------|------------------------------------------------------------------------------------------|
| make show                                                           | Displays the results file using the less pager                                           |
| make cache:clear                                                    | Deletes the project cache file to force a synchronization with the API                   |
| make help                                                           | List all of the available commands                                                       |
| make run QUERY="search_text" PROJECTS="project_name1,project_name2" | Run the tool. The QUERY parameter is mandatory. PROJECTS is optional (comma-separated).  |

## Usage without Make (Direct Commands)


#### Execute a search

```
docker compose run --rm gitlab-searcher "search_text" "project_name1,project_name2"
```

#### View results

```
less var/results/search_results.txt
```

#### Clear cache

```
rm -f var/cache/projects_cache.json
```

## Output File Structure

    **var/cache/projects_cache.json**: Temporarily stores the project list to optimize performance.

    **var/results/search_results.txt**: Contains the text dump of matches found during the last execution.
