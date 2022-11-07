import { LightningElement, api, wire, track } from 'lwc';
import jsonLoader from '@salesforce/apex/LoaderApp.jsonLoader';
import getAccounts from '@salesforce/apex/LoaderApp.getAccounts';
import { refreshApex } from "@salesforce/apex";


export default class LoaderAppContainer extends LightningElement {
    _title = 'Success';
    message = 'Batch Upload Started';
    variant = 'success';
    variantOptions = [
        { label: 'error', value: 'error' },
        { label: 'warning', value: 'warning' },
        { label: 'success', value: 'success' },
        { label: 'info', value: 'info' },
    ];
    wiredAccountsResult;
    @track columns = [
        {
            label: 'Account Name',
            fieldName: 'Name',
            type: 'text',
        },
        {
            label: 'NumberField',
            fieldName: 'NumberField__c',
            type: 'number',
        },
        {
            label: 'Percent Field',
            fieldName: 'PercentField__c',
            type: 'percent',
        }
    ];
    @api myRecordId;
    @track uploadedFiles;
    @track accountList;
    @track progress = 5000;

    @wire(getAccounts)
    wiredAccounts(result) {
        this.wiredAccountsResult = result;
        if (result.data) {
            this.accountList = [...result.data];
            this.error = undefined;
        } else if (result.error) {
            this.error = result.error;
            this.parameters = undefined;
        }
    }

    connectedCallback() {
        //Refresh the wireAccounts to get latests records
        this._interval = setInterval(() => {
            this.progress = this.progress + 2000;
            this.refreshData();
            if (this.progress === 600000) {
                clearInterval(this._interval);
            }
        }, this.progress);
    }

    @wire(jsonLoader, { uploadedFiles: '$uploadedFiles' })
    wireJsonLoader({ data, error }) {
        if (data) {
            const evt = new ShowToastEvent({
                title: this._title,
                message: this.message,
                variant: this.variant,
            });
            this.dispatchEvent(evt);
        } else if (error) {
            if (Array.isArray(error.body)) {
                this.error = error.body.map(e => e.message).join(', ');
            } else if (typeof error.body.message === 'string') {
                this.error = error.body.message;
            }
            console.log('There was an error: ' + this.error);
            console.error('ERROR => ', JSON.stringify(error)); // handle error properly
        }
    }

    get acceptedFormats() {
        return ['.json'];
    }

    refreshData() {
        return refreshApex(this.wiredAccountsResult);
    }

    handleUploadFinished(event) {
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;
        this.uploadedFiles = JSON.stringify(uploadedFiles);
    }
}