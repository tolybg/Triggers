trigger Opportunity_ai on Opportunity (after insert) 
{
    TaskService.addFollowUpTask(Trigger.NewMap);
}