import { LightningElement, api } from 'lwc';

export default class PortfolioUserDetails extends LightningElement {
    @api recordId
    @api objectApiName
    @api resumeUrl
    downloadResume(){
        window.open(this.resumeUrl,"_blank")
    }

    // downloadResume(){
    //     window.open("https://github.com/nagurukarimulla/karim-reume/blob/main/Karim%20Resume.docx","_blank")
    // }
}