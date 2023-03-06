How to setup pipeline:
======================

1.  **Clone the repository**

2.  **Add '.gitlab-ci.yml' to the git branch 'local/main'**

    1.  Make sure that the name is correctly '.gitlab-ci.yml' with a dot at the start, otherwise the pipeline will not run

3.  **Create CI/CD variables in GitLab → Project → Settings → CI/CD → Variables**

    1.  Create a variable for each target org:

        1.  SFDX_AUTH_URL_PROD

        2.  SFDX_AUTH_URL_UAT

        3.  SFDX_AUTH_URL_DEV

    2.  Get the values with sfdx cli on your device

        1.  If possible create a separate user for the Deployment

        2.  Run sfdx auth:web:login --setalias my-org

        3.  Run sfdx force:org:display --verbose -u my-org

        4.  Find the 'Sfdx Auth Url' key in the response

    3.  Save the corresponding auth urls in the GitLab

4.  **Init 'main', 'uat', 'dev' branches**

    1.  Retrieve source from 'prod' org

    2.  Commit source to 'local/main'

    3.  Create Custom Setting in the target org:

        1.  Label: 'GitlabSettings'

        2.  API name: 'GitlabSettings__c'

        3.  Create a new field on this custom setting

            1.  Label: 'CommitHash'

            2.  API name: 'CommitHash__c'

        4.  Optional:\
            Add Default Organization Level Value and set 'CommitHash__c' with the last commit's hash from your 'local/main' branch\
            It's useful if you don't want to redeploy everything later on the first push in the next step

    4.  Push 'local/main' to remote

    5.  Do these steps above for 'uat', 'dev' branches with the corresponding target orgs as well

5.  **Protect branches in GitLab → Project → Settings → Repository → Protected branches**

    1.  Set branches to protected:

        1.  'main'

        2.  'uat'

        3.  'dev'

Considerations:
===============

-   If your GitLab CI/CD **variables are protected**, then **make sure that your branches are protected**  as well, because: "Protected variables only exposed to protected branches or protected tags."

-   There is a setting in GitLab → Project → Settings → CI/CD → General pipelines → Git shallow clone

    -   Meaning: "**The number of changes to fetch from GitLab when cloning a repository.**"

    -   By default it's: **20**

    -   You might need to increase this number, if the 'CommitHash' found in the org's custom setting is 'too old'. It can happen, when you merge 'too many' commits to the target branch, and the pipeline fails, so the last successfully deployed commit hash is not updated in the target org

Resources:
==========

-   <https://www.salesforceben.com/build-your-own-ci-cd-pipeline-in-salesforce-using-github-actions/>

-   <https://github.com/scolladon/sfdx-git-delta>

-   <https://github.com/mehdisfdc/sfdx-cli-gitlab>
