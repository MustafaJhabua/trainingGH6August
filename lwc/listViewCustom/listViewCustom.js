import { LightningElement, track, api, wire } from 'lwc';
import { NavigationMixin, CurrentPageReference } from 'lightning/navigation';
import groToolRecords from '@salesforce/apex/NewContactController.groToolRecords';
import USER_ID from '@salesforce/user/Id';

// import { getListUi } from 'lightning/uiListApi';

export default class ListViewCustom extends NavigationMixin(LightningElement) {
    @api recordId;
    @api fields = ['Name','Email'];
    @api relatedRecordId;
    @api sectionTitle;
    @api updatedAccountName;
    @track records;
    @track error;
    @api currentPageReference;
    tempUrl;
    recordsArray = [];
    temp = [];
    

    @wire(CurrentPageReference) currentPageReference;

    connectedCallback() {
        if(this.currentPageReference.state.c__view) {
            this.recordId = this.currentPageReference.state.c__view;
            this.relatedRecordId = this.currentPageReference.state.c__view;
        }
        if(this.currentPageReference.state.c__type) {
            console.log(this.template.querySelector('lightning-record-form'));
            this.relatedRecordId = this.currentPageReference.state.c__view;
        }
    }

    @wire(groToolRecords, { filter: USER_ID })
    wiredGroToolRecords({data, error}) {
        if (data) {
            this.records = data;
            // this.temp = JSON.parse(JSON.stringify(data));
            // for (let index = 0; index < this.temp.length; index++) {
            //     if( this.temp[index].Integrated_formula__c ) {
            //         this.temp[index].Integrated_formula__c = Math.round(this.temp[index].Integrated_formula__c);
            //     } else {
            //         this.temp[index].Integrated_formula__c = '0';
            //     }
            // }
            // this.records = this.temp;
        } else if(error) {
            console.log(error);
        }
    }

    handleClick(evt) {
        evt.preventDefault();
        evt.stopPropagation();
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
               apiName: 'G_Test'
            },
            state: {
                'c__view': evt.target.dataset.recordId
            }
        });
        this.recordId = evt.target.dataset.recordId;
        this.relatedRecordId = this.recordId;
    }

    refreshDetailPage(data) {
        this.sectionTitle = 'Care Team Member';
        this.recordId = data.detail;
        this.relatedRecordId = data.detail;
        // this.fields = ['Name','Email','Phone','Care_Team_Member_Roles__c', 'Care_Team_Member__c','Comment__c'];
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
               apiName: 'G_Test'
            },
            state: {
                'c__view': data.detail,
                'c__type': 'ctm'
            }
        });
        setTimeout(() => {
           location.reload(); 
        }, 1000);
    }

    openListView() {
        location.href = '/lightning/n/G_Test';
    }
}