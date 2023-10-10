Global class PositionsQueueable implements System.Queueable
{
    /*
     * 	1. Constructor Name should be always same as the Class Name.
     *  2. Constructors are used to assign the default values for the class members.
     *  3. Constructor should be always defined with "Public" access specifier.
     *  4. Constructor doesn't have any return type even void.
     *  5. Constructor can have one or more parameters.
     */
     
    Hiring_Manager__C hrRecord;
    
    Public PositionsQueueable(Hiring_Manager__C hr)
    {
        hrRecord = hr;
    }
    
	Global void Execute(System.QueueableContext qContext)
    {
     	// Write the Code to Create a Related Position Record..
     		Position__C pos = new Position__C();
        		
        		pos.Name = 'Salesforce Marketing Cloud Consultant';
        		pos.Location__c = hrRecord.Location__c;
        		pos.Position_Status__c = 'New Position';
        		pos.Number_of_Positions__c = 2;
        		pos.Open_Date__c = system.today();
        		pos.Milestone_Date__c = system.today().AddDays(30);
        		pos.HR_Contact_Number__c = hrRecord.Contact_Number__c;
        		pos.HR_Email_ID__c = hrRecord.Email_ID__c;
        		pos.Minimum_Budget__c = 1400000;
        		pos.Maximum_Budget__c = 1800000;
        		pos.Passport_Required__c = true;
        		pos.Travel_Required__c = true;
        		pos.Position_Description__c = 'Required 2+ years of experience in Salesforce Marketing Cloud.';
        		pos.Skills_Required__c = 'Required 2+ years experience in Email Studio, Journey Builder, Content Builder, Mobile Studio.';
        		
				// Make the Position To be Related to HR.
				pos.Hiring_Manager__c = hrRecord.Id;
        
        	insert pos;
        	if(pos.Id != null)
            {
                system.debug('Position Record Inserted with id...: '+ pos.Id);
            }
    }
}