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

## Firebase CI with GitHub Actions

Use GitHub Actions to deploy a Firebase project

### Prerequisites

- node
- yarn
- docker

#### Firebase

- Create Firebase project

#### Firebase token

- Install firebase-tools locally `yarn global add firebase-tools`
- Get the `$FIREBASE_TOKEN` on firebasetool by running: `firebase login:ci`

#### Secrets (Environment variables)

- Add the generated Firebase Token to GitHub Secrets `(Settings > Add a new secret)` with variable name `FIREBASE_TOKEN`
- Add the Firebase's Project Name to GitHub Secrets `(Settings > Add a new secret)` with variable name `FIREBASE_PROJECT_NAME`

#### Actions configuration

- Go to `GitHub > Actions > Setup a new workflow yourself`

```yml
name: Deploy to Production

on:
  pull_request:
    branches:
    - master
jobs:
  setup:
    runs-on: ubuntu-latest
    steps:
    - uses: docker://ntwob/node-yarn-firebase
    - name: Use node-yarn-firebase Doker
  build:
    needs: setup
    steps:
    - name: install
      run: yarn install
    - name: lint
      run: yarn lint:prod
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

And now every commit pushed to `master` branch will build, lint, test and deploy your changes to Firebase

## Acknowledgments

- Heavily inspired on (excellet!) the work of [roalcantara](https://github.com/roalcantara/node-yarn-firebase-docker)
