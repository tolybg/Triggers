trigger Task_au on Task (after update) 
{
    OpportunityService.setOppValuesFromTasks(Trigger.newMap, Trigger.oldMap);
}