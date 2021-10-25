# Coding 101 - Working with the Database

# Setup

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repository

Create a [new branch](https://docs.github.com/en/github/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-and-deleting-branches-within-your-repository) - name it whatever you like, but note it down!

[Clone](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository-from-github/cloning-a-repository) to your local machine

On your local machine, `cd` into the directory created for your clone and switch to your new branch using the command:

`git checkout <branchname>`

## Challenge

1. Create a trigger that runs when opportunities are created that does the following:

- Creates a task associated with the opportunity to follow up in 10 days time 
- If the Opportunity amount is over 500000 creates a task with the subject  ‘Reduce Value’ that is associated with the opportunity, due for completion in two days.
- Implement in the `Opportunity_ai` trigger and `TaskService` class 

2. Create a trigger that runs when tasks are updated that does the following:

- If the task has a subject of ‘Reduce Value’ and the status is ‘Completed’, update the associated opportunity to reduce the amount by 50%.
- Create your own trigger and service class.

### Notes
The triggers may receive up to 200 records at a time, so ensure you are working efficiently with code that impacts governor limits.

The triggers should hand off to Apex classes to carry out the actual work.

HINT: You would associate sObjects with tasks via the WhatId field.


## Implementing

Carry out all work in your local filesystem using VS Code, as you will 
need to send them back to Github.

1. Create a scratch org (or connect to an existing one)
1. Edit the class `force-app/main/default/classes/Homework.cls` and add the code
   requested in the comments. 
1. Push the code to your scratch org - this will check that your code compiles

## Submitting Your Solution for Assessment

Please note that assessment is only available to BrightGen employees or by prior arrangement with Keir Bowden (aka Bob Buzzard). If you don't satisfy this criteria your pull request will not be reviewed.

Add `keirbowden` as a [collaborator](https://docs.github.com/en/github/setting-up-and-managing-your-github-user-account/managing-access-to-your-personal-repositories/inviting-collaborators-to-a-personal-repository) to your new repository

The commands below are if you are using Git from the command line - you can also use the VS Code built-in [source control functionality](https://code.visualstudio.com/docs/editor/versioncontrol).

Stage your updated Homework class using the following command: 

`git add force-app/main/default/classes`

and then commit the changes :

`git commit`

and push these to the remote repository

`git push origin <branchname>`

Once you are happy with your solution, [open a pull request](https://docs.github.com/en/github/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request)

Then wait!

