import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/TableController.getAccounts'
import getOpportunities from '@salesforce/apex/TableController.getOpportunities'
import {exportCSVFile} from 'c/utils'
export default class CsvDemo extends LightningElement {
    accountData
    @wire(getAccounts)
    accountHandler({data}){
        if(data){
            console.log(data)
            this.accountData = data
        }
    }
    accountHeaders ={
        Id:"Record Id",
        Name:"Name",
        AnnualRevenue:"Annual Revenue",
        Industry:"Industry",
        Phone:"Phone"
    }

    opportunityData
    @wire(getOpportunities)
    opportunityHandler({data}){
        if(data){
            console.log(data)
            this.opportunityData = data
        }
    }
    opportunityHeaders ={
        Name:"Opportunity Name",
        AccountId:"Account Id",
        LeadSource:"Lead Source",
        ExpectedRevenue:"Expected Revenue"

    }
    downloadAccountData(){
        exportCSVFile(this.accountHeaders, this.accountData, "accounts detail")
    }

    downloadOpportunityData(){
        exportCSVFile(this.opportunityHeaders, this.opportunityData, "opportunity detail")
    }
}