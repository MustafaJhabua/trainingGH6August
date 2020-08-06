import { LightningElement, track, api, wire } from 'lwc';
import getChildRecords from '@salesforce/apex/NewContactController.getChildRecords';
import getActivityTask from '@salesforce/apex/NewContactController.getActivityTask';
import updateTaskObject from '@salesforce/apex/TaskLWC.updateTask';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from "@salesforce/apex";

export default class RelatedLists extends LightningElement {
    @api
    relatedRecordId;
    fields = ['Name', 'Care_Team_Member__c','Mark_Completed__c','Date_Completed__c'];
    @track records;
    @track activityTasks;
    @track showSpinner = false;
    @track modal = {recordId:false,object:"Accout_Integration_Task__c",header:"Update Account Integration Task"};
    recordsArray = [];
    schedulers = [];
    schedulerSection;
    fills = [];
    fillsSection;
    educates = [];
    educatesSection;
    handles = [];
    handlesSection;
    draws = [];
    drawsSection;
    sends = [];
    sendsSection;
    reports = [];
    reportsSection;
    mds = [];
    mdsSection;
    relatedRecords;
    activityTaskList;

    @wire(getChildRecords, { supervisor: '$relatedRecordId' })
    wiredChildRelationships(value) {
        this.relatedRecords = value;
        if (value.data) {
            this.records = value.data;
            this.recordsArray = JSON.parse(JSON.stringify(value.data));
            if (this.recordsArray.length < 1) {
                this.records = false;
            } else {
                for (let index = 0; index < this.recordsArray.length; index++) {
                    if (this.recordsArray[index].Integration_Question__r.Support_Team_Care_Team_Role__c === "Identifies Patients") {
                        this.schedulers.push(this.recordsArray[index]);
                        this.schedulersSection = true;
                    } else if (this.recordsArray[index].Integration_Question__r.Support_Team_Care_Team_Role__c === "Fills out TRF") {
                        this.fills.push(this.recordsArray[index]);
                        this.fillsSection = true;
                    } else if (this.recordsArray[index].Integration_Question__r.Support_Team_Care_Team_Role__c === "Educates Patient") {
                        this.educates.push(this.recordsArray[index]);
                        this.educatesSection = true;
                    } else if (this.recordsArray[index].Integration_Question__r.Support_Team_Care_Team_Role__c === "Handles Billing") {
                        this.handles.push(this.recordsArray[index]);
                        this.handlesSection = true;
                    } else if (this.recordsArray[index].Integration_Question__r.Support_Team_Care_Team_Role__c === "Draws the Blood") {
                        this.draws.push(this.recordsArray[index]);
                        this.drawsSection = true;
                    } else if (this.recordsArray[index].Integration_Question__r.Support_Team_Care_Team_Role__c === "Sends the Kit") {
                        this.sends.push(this.recordsArray[index]);
                        this.sendsSection = true;
                    } else if (this.recordsArray[index].Integration_Question__r.Support_Team_Care_Team_Role__c === "Gets the Reports") {
                        this.reports.push(this.recordsArray[index]);
                        this.reportsSection = true;
                    } else {
                        this.mds.push(this.recordsArray[index]);
                        this.mdsSection = true;
                    }
                }
            }
        } else if(value.error) {
            console.log(value.error);
        }
    }

    @wire(getActivityTask, { filter: '$relatedRecordId' })
    getActivityTask (value) {
        this.activityTaskList = value;
        if (value.data) {
            let wiredResponse = JSON.parse(JSON.stringify(value.data));
            for (let index = 0; index < wiredResponse.length; index++) {
                if ( wiredResponse[index].Status === 'Completed' ) {
                    wiredResponse[index].checkboxStatus = true;
                } else {
                    wiredResponse[index].checkboxStatus = false;
                }
            }
            this.activityTasks = wiredResponse;
        } else if (value.error) {
            console.log(value.error);
        }
    }

    handleSuccess() {
        const evt = new ShowToastEvent({
            title : "Record Updated Succesfully",
            // message: "",
            variant: "success"
        });
        this.dispatchEvent(evt);
    }

    handleError() {
        const evt = new ShowToastEvent({
            title : "Something Went Wrong",
            // message: "",
            variant: "error"
        });
        this.dispatchEvent(evt);
    }
    
    handleClick(event) {
        event.preventDefault();
        this.modal.recordId = event.target.dataset.recordId;
    }

    closeModal() {
        this.modal.recordId = false;
    }

    closeSection(event) {
        if (event.target.parentElement.classList.contains('slds-is-open')) {
            event.target.parentElement.classList.toggle('slds-is-open')
        } else {
            event.target.parentElement.parentElement.classList.toggle('slds-is-open');
        }
    }  
    
    checkboxClick(event) {
        event.preventDefault();
    }

    handleNewSave() {
        this.schedulers.length = 0;
        this.fills.length = 0;
        this.educates.length = 0;
        this.handles.length = 0;
        this.draws.length = [];
        this.sends.length = 0;
        this.reports.length = 0;
        this.mds.length = 0;
        this.modal.recordId = false;
        return refreshApex(this.relatedRecords);
    }

    updateTask(event) {
        this.showSpinner = true;
        let status = 'In Progress';
        console.log(event.target.dataset.recordId);
        if ( event.detail.checked ) {
            status = 'Completed';
        }
        if ( event.target.dataset.recordId ) {
            updateTaskObject( { status : status, taskId : event.target.dataset.recordId } )
            .then(result => {
                console.log('Result');
                console.log(result);
                const evt = new ShowToastEvent({
                    title : "Task Updated Succesfully",
                    // message: "",
                    variant: "success"
                });
                this.dispatchEvent(evt);
                this.showSpinner = false;
            })
            .catch(error => {
                console.log(error);
                const evt = new ShowToastEvent({
                    title : "Something went Wrong",
                    message: error,
                    variant: "error"
                });
                this.dispatchEvent(evt);
                this.showSpinner = false;
            });
        }
    }
}