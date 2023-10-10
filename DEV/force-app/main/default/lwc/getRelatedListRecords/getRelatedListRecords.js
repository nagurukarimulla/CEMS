import { LightningElement, wire} from "lwc";
import { getRelatedListRecords } from "lightning/uiRelatedListApi";

export default class GetRelatedListRecords extends LightningElement {
    
    error;
    records;
    @wire(getRelatedListRecords, {
      parentRecordId: "0015i00000Wq4QPAAZ",
      relatedListId: "Contacts",
      fields: ["Contact.Id", "Contact.Name"],
      //where: '{ and:[{Name:{like:"Test%"}}]}'
    })
    const({ error, data }) {
      if (data) {
        this.records = data.records;
        this.error = undefined;
      } else if (error) {
        this.error = error;
        this.records = undefined;
      }
    }
  }