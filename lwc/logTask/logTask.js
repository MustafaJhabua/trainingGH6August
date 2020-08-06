import { LightningElement, track, api } from 'lwc';
import createTask from "@salesforce/apex/TaskLWC.createTask";
import { ShowToastEvent } from 'lightning/platformShowToastEvent'

export default class LogTask extends LightningElement {
    @api whoId;
    @api contactType;
    @track _selected = [];
    dueDate;
    @track option;
    @track reRender;
    @track showSpinner;

    get options() {
        if ( this.contactType === 'Care Team Member' ) {
            this.option = [
                { label: 'Attended a PEP event', value: 'Attended a PEP event' },            
                { label: 'COS face to face', value: 'COS face to face' },
                { label: 'Helped identify patients', value: 'Helped identify patients' },
                { label: 'Provided user feedback', value: 'Provided user feedback' },
                { label: 'Retrained', value: 'Retrained' }
            ];
        } else {
            this.option = [
                { label: 'Attended a PEP event', value: 'Attended a PEP event' },            
                { label: 'Case review', value: 'Case review' },
                { label: 'COS face to face', value: 'COS face to face' },
                { label: 'Provided user feedback', value: 'Provided user feedback' }
            ];
        }
        return this.option;
    }

    get selected() {
        return this._selected.length ? this._selected : 'none';
    }

    handleChange(e) {
        this._selected = e.detail.value;
    }

    getDate(event) {
        this.dueDate = event.target.value;
    }

    submitTask() {
        this.showSpinner = true;
        let subject = JSON.parse(JSON.stringify(this._selected));
        if( subject.length > 0 ) {
            subject = JSON.parse(JSON.stringify(this._selected)).toString();
            createTask({ subject : subject, whoId: this.whoId })
                .then(result => {
                    console.log(result);
                    this.showSpinner = false;
                    this.showToast('Success','Task Created Successfully','success');
                    this._selected.length = 0;
                    this.dueDate = null;
                    this.reRender = true;
                    this.dispatchEvent(new CustomEvent('taskaddedsuccessfully'));
                })
                .catch(error => {
                    this.showToast('Error',error.body.message,'error');
                });
        }
        else
        {
            this.showToast('Error','Please Select atleast One Subject','error');
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

    hideLogTaskWindow() {
        this.dispatchEvent(new CustomEvent('cancelclick'));
    }
}