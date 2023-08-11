Org Development Model
=====================

Our pipeline implementation:
----------------------------

-   <https://gitlab.com/bitmist/bmt/gitlabpipeline>

Docker Image:
-------------

-   <https://hub.docker.com/repository/docker/bitmist/cicd/general>

How to setup pipeline:
----------------------

1.  **Clone the repository**

2.  **Add '.gitlab-ci.yml', '.include' to the git branch 'local/main'**

    1.  Make sure that the name is correctly '`.gitlab-ci.yml`', '.include' with a dot at the start, otherwise the pipeline will not run

3.  **Create CI/CD variables in GitLab → Project → Settings → CI/CD → Variables**

    1.  Create a variable for each target org:

        1.  SFDX_AUTH_URL_MAIN

        2.  SFDX_AUTH_URL_UAT

        3.  SFDX_AUTH_URL_DEV

    2.  Get the values with sfdx cli on your device

        1.  If possible create a separate user for the Deployment

        2.  Run sfdx org:login:web -a my-org

        3.  Run sfdx org:display --verbose -o my-org

        4.  Find the 'Sfdx Auth Url' key in the response

    3.  Save the corresponding auth urls in the GitLab

4.  **Init 'main', 'uat', 'dev' branches**

    1.  Retrieve source from 'prod' org

    2.  Commit and push source to 'local/main'

    3.  Do these steps above for 'uat', 'dev' branches with the corresponding target orgs as well

5.  **Protect branches in GitLab → Project → Settings → Repository → Protected branches**

    1.  Set branches to protected:

        1.  'main'

        2.  'uat'

        3.  'dev'

Considerations:
---------------

-   If your GitLab CI/CD **variables are protected**, then **make sure that your branches are protected**  as well, because: "Protected variables only exposed to protected branches or protected tags."

-   There is a setting in GitLab → Project → Settings → CI/CD → General pipelines → Git shallow clone

    -   Meaning: "**The number of changes to fetch from GitLab when cloning a repository.**"

    -   By default it's: **20**

    -   You **might need to increase** this number, the last tagged commit 'too old'. It can happen, when you merge 'too many' commits to the target branch, without deployment.

Resources:
----------

-   <https://www.salesforceben.com/build-your-own-ci-cd-pipeline-in-salesforce-using-github-actions/>

-   <https://github.com/scolladon/sfdx-git-delta>

-   <https://github.com/mehdisfdc/sfdx-cli-gitlab>

-   <https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference_top.htm>
