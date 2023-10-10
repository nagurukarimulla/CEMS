import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const GITHUB_URL = 'https://api.github.com/users/';

export default class GithubInfo extends LightningElement {
    username;
    user = {};

    get userPopulated() {
        return this.user && this.user.id;
    }

    get githubURL() {
        return 'https://www.github.com/' + this.username;
    }

    updateUsername(event) {
        this.username = event.target.value;
    }

    getGithubStats() {
        if(this.username) {
            this.user = {};
            fetch(GITHUB_URL + this.username)
            .then(response => {
                console.log(response);
                if(response.ok) {
                    return response.json();
                } else {
                    throw Error('Invalid username');
                }
            })
            .then(githubUser => {
                this.user = {
                    id: githubUser.id,
                    name: githubUser.name,
                    image: githubUser.avatar_url,
                    blog: githubUser.blog,
                    about: githubUser.bio,
                    repos: githubUser.public_repos,
                    gists: githubUser.public_gists,
                    followers: githubUser.followers
                };
            })
            .catch(error => {
                console.log(error);
                const event = new ShowToastEvent({
                    title: 'Error',
                    message: 'Invalid username',
                    variant: 'error'
                });
                this.dispatchEvent(event);
            });
        } else {
            const event = new ShowToastEvent({
                title: 'Error',
                message: 'Please specify a username',
                variant: 'error'
            });
            this.dispatchEvent(event);
        }
    }
}