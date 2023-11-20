global class DailyLeadProcessor implements Schedulable {
    global void execute(SchedulableContext ctx) {
        // awesome code here
        List<Lead> leads = new List<Lead>();
        for (Lead lead : [Select id, leadSource from lead where leadSource = null limit 200]) {
           lead.LeadSource = 'Dreamforce';
           leads.add(lead);
        }
        update leads;
    } 

}