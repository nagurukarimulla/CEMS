import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
const FIELDS = [
    'Contact.Title',
    'Contact.Phone',
    'Contact.Email',
    'Contact.Account.Name'
];

export default class Clipboard extends LightningElement {
    @api recordId;
    @api Email;
    @api Title;
    @api Phone;
    @api AccountName;
    contact;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    wiredContact({ error, data }) {
        if (data) {
            this.contact = {
                Title: data.fields.Title.value,
                Phone: data.fields.Phone.value,
                Email: data.fields.Email.value,
                Account: {
                    Name: data.fields.Account.value.fields.Name.value
                }
            };
        } else if (error) {
            console.error(error);
        }
    }

    handleCopyAll() {
      let data = `Title: ${this.contact.Title}\nAccount Name: ${this.contact.Account.Name}\nPhone: ${this.contact.Phone}\nEmail: ${this.contact.Email}`;

      // Copy to clipboard
      navigator.clipboard.writeText(data).then(() => {
          console.log('All contact details copied to clipboard');

          // Show a success toast message
          const event = new ShowToastEvent({
              title: 'Success!',
              message: 'All contact details copied to clipboard',
              variant: 'success'
          });
          this.dispatchEvent(event);
      }, (err) => {
          console.error('Error copying all contact details to clipboard:', err);

          // Show an error toast message
          const event = new ShowToastEvent({
              title: 'Error!',
              message: 'An error occurred while copying contact details',
              variant: 'error'
          });
          this.dispatchEvent(event);
      });
  

        // Copy to notepad
        let notepadUrl = 'notepad.exe';
        let file = new Blob([data], {type: 'text/plain'});
        let url = URL.createObjectURL(file);
        let link = document.createElement('a');
        link.href = url;
        link.setAttribute('download', 'contact-details.txt');
        link.style.display = 'none';
        document.body.appendChild(link);
        link.click();
        setTimeout(function() {
            document.body.removeChild(link);
            URL.revokeObjectURL(url);
        }, 1000);
    }

    handleCopyPhone() {
        navigator.clipboard.writeText(this.contact.Phone).then(() => {
          console.log('Phone copied to clipboard');
          const toastEvent = new ShowToastEvent({
            title: 'Success!',
            message: 'Phone copied to clipboard',
            variant: 'success'
          });
          this.dispatchEvent(toastEvent);
        }, (err) => {
          console.error('Error copying phone to clipboard:', err);
          const toastEvent = new ShowToastEvent({
            title: 'Error',
            message: 'Error copying phone to clipboard',
            variant: 'error'
          });
          this.dispatchEvent(toastEvent);
        });
      }
      

    handleCopyEmail() {
        navigator.clipboard.writeText(this.contact.Email).then(() => {
          console.log('Email copied to clipboard');
          const toastEvent = new ShowToastEvent({
            title: 'Success!',
            message: 'Email copied to clipboard',
            variant: 'success'
          });
          this.dispatchEvent(toastEvent);
        }, (err) => {
          console.error('Error copying email to clipboard:', err);
          const toastEvent = new ShowToastEvent({
            title: 'Error',
            message: 'Error copying email to clipboard',
            variant: 'error'
          });
          this.dispatchEvent(toastEvent);
        });
      }
      

      handleCopyTitle() {
        navigator.clipboard.writeText(this.contact.Title).then(() => {
          console.log('Title copied to clipboard');
          const toastEvent = new ShowToastEvent({
            title: 'Success!',
            message: 'Title copied to clipboard',
            variant: 'success'
          });
          this.dispatchEvent(toastEvent);
        }, (err) => {
          console.error('Error copying title to clipboard:', err);
          const toastEvent = new ShowToastEvent({
            title: 'Error',
            message: 'Error copying title to clipboard',
            variant: 'error'
          });
          this.dispatchEvent(toastEvent);
        });
      }
      

    
      handleCopyAccountName() {
        navigator.clipboard.writeText(this.contact.Account.Name).then(() => {
          console.log('Account name copied to clipboard');
          const toastEvent = new ShowToastEvent({
            title: 'Success!',
            message: 'Account name copied to clipboard',
            variant: 'success'
          });
          this.dispatchEvent(toastEvent);
        }, (err) => {
          console.error('Error copying account name to clipboard:', err);
          const toastEvent = new ShowToastEvent({
            title: 'Error',
            message: 'Error copying account name to clipboard',
            variant: 'error'
          });
          this.dispatchEvent(toastEvent);
        });
      }
      
}
