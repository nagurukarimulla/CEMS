import { LightningElement } from 'lwc';

export default class QuerySelector extends LightningElement {
    userNames =["Karim", "Pradeep", "Kishore", "Pavan", "Surya"]
    fetchDetailHandler(){
        const elem = this.template.querySelector('h1')
        elem.style.border="5px dotted red";
        console.log(elem.innerText)

        const userElements = this.template.querySelectorAll('.name')
        Array.from(userElements).forEach(item=>{
            console.log(item.innerText)
            item.setAttribute("title", item.innerText)
        })

        ///  lwc:dom="manual" demo
        const childElem = this.template.querySelector('.child')
        childElem.innerHTML = '<p><b>Hey this is a child element<b></p>'
    }
}