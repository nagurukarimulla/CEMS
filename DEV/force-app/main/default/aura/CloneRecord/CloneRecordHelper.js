({
    fetchOppoHelper : function(component, event, helper) {
        component.set('v.mycolumns', [
            {label: 'Opportunity Name', fieldName: 'Name', type: 'text'},
            {label: 'Lead Source', fieldName: 'LeadSource', type: 'Picklist'},
            {label: 'Stage', fieldName: 'StageName', type: 'Picklist'},
            {label: 'Description', fieldName: 'Description', type: 'text'},
            {type: "button", typeAttributes: {
                label: 'View',
                name: 'View',
                title: 'View',
                disabled: false,
                value: 'view',
                iconPosition: 'left'
            }},

            {type: "button", typeAttributes: {
                label: 'Edit',
                name: 'Edit',
                title: 'Edit',
                disabled: false,
                value: 'edit',
                iconPosition: 'left'
            }},
                {type: "button", typeAttributes: {
                label: 'Create',
                name: 'Create',
                title: 'Create',
                disabled: false,
                value: 'create',
                iconPosition: 'left'

            }}
            ]);

        var action = component.get("c.fetchOpportunities");
        action.setParams({

        });

        action.setCallback(this, function(response){

            var state = response.getState();

            if (state === "SUCCESS") {

                component.set("v.oppoList", response.getReturnValue());

            }

        });

        $A.enqueueAction(action);

    },

    viewRecordHelper : function(component, event, helper) {

        var recId = event.getParam('row').Id;

        var actionName = event.getParam('action').name;

        if ( actionName == 'Edit' ) {

            alert('Edit');

            var editRecordEvent = $A.get("e.force:editRecord");

            alert('editRecordEvent'+editRecordEvent);

            editRecordEvent.setParams({

                "recordId": recId
            });
            editRecordEvent.fire();
        }else if(actionName == 'Create'){
            alert('Create');
            var createRecordEvent = $A.get("e.force:createRecord");
            createRecordEvent.setParams({
                "entityApiName": "Opportunity"
            });
            createRecordEvent.fire();
        }else if ( actionName == 'View') {

            alert('view');

            var viewRecordEvent = $A.get("e.force:navigateToURL");

             alert('viewRecordEvent'+viewRecordEvent);

            viewRecordEvent.setParams({

                "url": "/" + recId

            });

            viewRecordEvent.fire();

        }

    }

})