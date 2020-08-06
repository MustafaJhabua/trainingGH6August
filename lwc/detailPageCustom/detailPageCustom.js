import { LightningElement, api, track, wire } from 'lwc';
import { NavigationMixin, CurrentPageReference } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getCareTeamMemberAccount from '@salesforce/apex/NewContactController.getCareTeamMemberAccount';
import getIntegrationContactType from '@salesforce/apex/NewContactController.getIntegrationContactType';

export default class DetailPageCustom extends NavigationMixin(LightningElement) {
    @api recordId;
    @api relatedRecordId;
    @api fields = ['Name','Email'];
    @track isCareTeamMember;
    @api sectionTitle;
    @track isPhysician;
    @track justForRerender;
    @track updatedAccountName;
    @track logTaskShow;

    @wire(CurrentPageReference) pageRef;

    // get currentPageReference() {
    //     return this.pageRef ? JSON.stringify(this.pageRef, null, 2) : '';
    // }

    connectedCallback() {
        console.log('Connected Detail Page');
        if( this.pageRef.state.hasOwnProperty('c__view') === true ) {
            this.recordId = this.pageRef.state.c__view;
            this.relatedRecordId = this.pageRef.state.c__view;
        }
        // else if( this.pageRef.state.hasOwnProperty('c__view') === false ) {
        //     this[NavigationMixin.Navigate]({
        //         type: 'standard__navItemPage',
        //         attributes: {
        //             apiName: "G_Test"
        //         }
        //     });
        // }
    }

    // renderedCallback() {
    //     console.log('Rendered!!');
    //     console.log(this.pageRef);
        // if( this.recordId !== this.pageRef.state.c__view ) {
        //     this.recordId = this.pageRef.state.c__view;
        // }
    // }

    // renderedCallback() {
    //     console.log('Renderd');
    //     if( this.pageRef.state.hasOwnProperty('c__view') === false ) {
    //         this[NavigationMixin.Navigate]({
    //             type: 'standard__navItemPage',
    //             attributes: {
    //                apiName: "G_Test",
    //             }
    //         });
    //     }
    // }

    @wire(getIntegrationContactType, { filter : '$recordId' })
    getIntegrationContactType ({data, error}) {
        if (data) {
            if (data === 'Care Team Member') {
                this.fields = ['Name','Email','Phone','Care_Team_Member_Roles__c','Comment__c'];
                this.sectionTitle = 'Care Team Member';
                this.isPhysician = false;
            }
            else
            {
                this.fields = ['Name','Email','Integrated_formula__c','Phone','Comment__c'];
                this.sectionTitle = 'Physician';
                this.isPhysician = true;
            }
        } else if (error) {
            console.log(error);
        }
    }

    @wire(getCareTeamMemberAccount, { filter: '$recordId' })
    getCareTeamMemberAccount({data, error}) {
        if (data) {
            this.updatedAccountName = data;
        } else if(error) {
            this.error = error;
        }
    }

    handleSuccess() {
        const evt = new ShowToastEvent({
            title: "Record Updated Successfully",
            // message: this.message,
            variant: "success",
        });
        this.dispatchEvent(evt);
    }

    handleError() {
        const evt = new ShowToastEvent({
            title: "Something Went Wrong",
            // message: this.message,
            variant: "error",
        });
        this.dispatchEvent(evt);
    }

    selectedCareTeamMember(data) {
        this.dispatchEvent(new CustomEvent('againselected',{detail:data.detail}));
    }
    
    modalSaved(data) {
        console.log(data);
        setTimeout(() => {
            location.reload();
        }, 1000);
    }

    openLogTaskWindow() {
        this.logTaskShow = true;
    }

    hideLogTaskWindow() {
        this.logTaskShow = false;
    }
}