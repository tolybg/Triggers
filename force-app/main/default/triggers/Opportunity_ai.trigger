trigger Opportunity_ai on Opportunity (after insert) 
{
    //TODO: if(!Triggers.Stop)

    TaskService.addFollowUpTask(Trigger.NewMap);
}