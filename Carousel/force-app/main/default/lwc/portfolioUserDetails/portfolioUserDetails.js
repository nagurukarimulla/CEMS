import { LightningElement, api } from 'lwc';

export default class PortfolioUserDetails extends LightningElement {
    @api recordId
    @api objectApiName

    downloadResume(){
        window.open("https://github.com/nagurukarimulla/karim-reume/blob/main/Karim%20Resume.docx","_blank")
    }
}