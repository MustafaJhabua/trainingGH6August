import { LightningElement, track, api, wire } from 'lwc';
import getChildContacts from '@salesforce/apex/NewContactController.getChildContacts';
import getCareTeamMemberAccountId from '@salesforce/apex/NewContactController.getCareTeamMemberAccountId';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class DetailPageSection extends NavigationMixin(LightningElement) {
    @api recordId;
    @api modal = {open:false,record:this.recordId,accountId:null,header:'Create New Care Team Member'};
    // fields = ['Name', 'Title', 'Email', 'Phone','Care_Team_Member__c','AccountId','Care_Team_Member_Roles__c'];
    @track records;
    @track error;
    @track accountId;
    @track spinner;

    @wire(getChildContacts, { filter: '$recordId' })
    getChildContacts({data, error}) {
        if (data) {
            console.log('Success!');
            this.records = data;
        } else if(error) {
            console.log('Error!');
            console.log(error);
            this.error = error;
        }
    }

    @wire(getCareTeamMemberAccountId, { filter: '$recordId' })
    getCareTeamMemberAccountId({data, error}) {
        if (data) {
            this.accountId = data
        } else if(error) {
            this.error = error;
        }
    }

    @api createNewContact(){
        this.modal = {open:true,record:this.recordId,accountId:this.accountId,header:"Create New Care Team Member"};
    }

    handleClick(event) {
        event.preventDefault();
        const selectEvent = new CustomEvent('selected', {
            detail: event.target.dataset.recordId
        });
        this.dispatchEvent(selectEvent);
    }

    handleLoadCreate(event) {
        console.log(event.detail.record);
        const data = JSON.parse(JSON.stringify(event.detail));
        data.record.fields.Care_Team_Member__c.value = this.recordId;
    }
    
    handleReset() {
        const inputFields = this.template.querySelectorAll(
            'lightning-input-field'
        );
        if (inputFields) {
            inputFields.forEach(field => {
                field.reset();
            });
        }
        this.modal = false;
    }

    handleSubmit(){
        this.spinner = true;        
        // event.preventDefault();       // stop the form from submitting
        // const fields = event.detail.fields;
        // fields.Integration_Contact_Type__c = 'Care Team Member'; // modify a field
        // this.template.querySelector('lightning-record-edit-form').submit(fields);
        // this.modal = false;
    }

    handleSuccess(event) {
        this.toastEvent(event, "Record Updated Successfully", '', "success");
    }

    handleError(event) {
        this.toastEvent(event, "Something Went Wrong", '', "error");
    }

    handleNewSave(event) {
        this.toastEvent(event, "Record Created Successfully", '', "success");
        this.modal = false;
        const evt = new CustomEvent('save', {
            detail: true
        });
        this.dispatchEvent(evt);
    }

    toastEvent(event, title, msg, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: msg,
            variant: variant,
        });
        this.dispatchEvent(evt); 
    }

    closeModal() {
        this.modal = false;
    }

    handleErrorCT(event) {
        console.log('Error while Creating !!');
        console.log(event);
    }

}