import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import sendNegotiatedOfferEmail from '@salesforce/apex/EmailSender.sendNegotiatedOfferEmail';

export default class SendNegotiatedOfferEmail extends LightningElement {
  @track employeeEmail;
  
  handleEmployeeEmailChange(event) {
    this.employeeEmail = event.target.value;
  }
  
  handleSendEmail() {
    if (this.employeeEmail) {
      // Check if the offer has been approved by all concerned parties based on the percentage of adjusted salary
      let isApproved = true; // Replace with your approval logic
      
      if (isApproved) {
        // Call Apex method to send the email to the employee
        sendNegotiatedOfferEmail({ employeeEmail: this.employeeEmail })
          .then(result => {
            // Handle success
            this.showToast('Success', 'Email Sent Successfully', 'success');
          })
          .catch(error => {
            // Handle error
            console.error(error);
            this.showToast('Error', 'An error occurred while sending the email', 'error');
          });
      } else {
        this.showToast('Error', 'The offer has not been approved yet', 'error');
      }
    } else {
      this.showToast('Error', 'Please provide employee email', 'error');
    }
  }
  
  showToast(title, message, variant) {
    const event = new ShowToastEvent({
      title: title,
      message: message,
      variant: variant
    });
    this.dispatchEvent(event);
  }
}
