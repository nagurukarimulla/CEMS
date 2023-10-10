import { LightningElement, track } from 'lwc';




export default class SalesforceLogin extends LightningElement {
   @track username;
  @track password;
  @track error;

  handleUsernameChange(event) {
    this.username = event.target.value;
  }

  handlePasswordChange(event) {
    this.password = event.target.value;
  }

  async connectToSalesforce() {
    this.error = undefined;
    const response = await fetch('https://test.salesforce.com/services/oauth2/token', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: `grant_type=password&client_id=<your_client_id>&client_secret=<your_client_secret>&username=${this.username}&password=${this.password}`
    });

    if (!response.ok) {
      this.error = await response.text();
      return;
    }

    const json = await response.json();
    console.log(json);
    // You can now use the access token to make authorized API requests
  }
}