# Node 8, Yarn and Firebase Docker image

Lightweight Docker image with:

- NodeJS 8.x
- Yarn
- Firebase Admin
- Firebase Functions
- Firebase Tools

## Installing

Can be pulled from Docker Hub

```docker
docker pull roalcantara/node-yarn-firebase
```

### Usage

```docker
docker ps
docker inspect roalcantara/node-yarn-firebase
docker run -it roalcantara/node-yarn-firebase yarn
```

## Development

```docker
docker build -t roalcantara/node-yarn-firebase .
docker tag roalcantara/node-yarn-firebase roalcantara/node-yarn-firebase:v.0.0
docker push roalcantara/node-yarn-firebase
```

## Automate your Firebase's CI with [GitHub Actions](https://github.com/features/actions)

Use [GitHub Actions](https://github.com/features/actions) to deploy a [Firebase Project](https://firebase.google.com/docs/functions/get-started).

### Prerequisites

- node
- yarn
- docker

#### Create a [Firebase's](https://firebase.google.com/docs/functions/get-started) Project

Cloud Functions for Firebase let you automatically run backend code in response to events triggered by Firebase features and HTTPS requests.

- Follow the steps on the [Get Started](https://firebase.google.com/docs/functions/get-started) tutorial
- Run `yarn global add firebase-tools` to install firebase-tools locally
- Run `firebase login` to log in via the browser and authenticate the firebase tool
- Go to your Firebase project directory
- Run `firebase init functions`

#### [Firebase Token](https://firebase.google.com/docs/cli#admin-commands)

Generate an authentication token for use in non-interactive environments.

- Get the `$FIREBASE_TOKEN` on firebase-tools by running: `firebase login:ci`

#### [GitHub Secrets (Environment variables)](https://help.github.com/en/articles/virtual-environments-for-github-actions#creating-and-using-secrets-encrypted-variables)

Secrets are encrypted environment variables created in a repository and can only be used by GitHub Actions.

- On GitHub, navigate to the main page of the repository
- Under your repository name, click `[Settings]`
- In the left sidebar, click `[Secrets]`
- Click on `[Add a new secret]` and add the generated Firebase Token with the name `FIREBASE_TOKEN`
- Click on `[Add a new secret]` and add the Firebase's Project Name with the name `FIREBASE_PROJECT_NAME`

#### [GitHub Actions Configuration](https://help.github.com/en/articles/about-github-actions)

GitHub Actions enables you to create custom software development lifecycle workflows directly in your GitHub repository.

- On GitHub, navigate to the main page of the repository
- Under your repository name, click `[Actions]`
- Find the `"Popular continuous integration workflows"` section
- Find the `"Node.js"` workflow
- Click on `"Set up this workflow"`
- On `Edit new file` paste

```yml
name: Deploy to Firebase

on:
  pull_request:
    branches:
    - master
jobs:
  setup:
    steps:
    - name: Use node-yarn-firebase Doker
    - uses: docker://roalcantara/node-yarn-firebase
  build:
    needs: setup
    steps:
    - name: install
      run: yarn install
    - name: lint
      run: yarn lint
    - name: test
      run: yarn test
    - name: build
      run: yarn build
  deploy:
    needs: build
    steps:
    - name: deploy
      env:
        FIREBASE_TOKEN: ${{ secrets.FIREBASE_TOKEN }}
        FIREBASE_PROJECT_NAME: ${{ secrets.FIREBASE_PROJECT_NAME }}
      run: firebase deploy --token=$FIREBASE_TOKEN --project=$FIREBASE_PROJECT_NAME --non-interactive
```

#### Conclusion

And now every commit pushed to `master` will build, lint, test and deploy the changes to Firebase.

## Acknowledgments

- Heavily inspired on (excellet!) the work of [bartholomej](https://github.com/bartholomej/angular-firebase-docker).
