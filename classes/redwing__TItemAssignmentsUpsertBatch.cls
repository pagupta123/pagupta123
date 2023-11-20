/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class TItemAssignmentsUpsertBatch implements Database.Batchable<SObject>, Database.Stateful {
    global String batchType;
    global String communityId;
    global Date dueDate;
    global String elementId;
    global String tPlanBatchOpId;
    global Set<Id> userIds;
    global TItemAssignmentsUpsertBatch(String batchType, String elementId, String tpboId, Set<Id> userIds, String communityId, Date dueDate) {

    }
    global void execute(Database.BatchableContext BC, List<SObject> scope) {

    }
    global void finish(Database.BatchableContext BC) {

    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return null;
    }
}
