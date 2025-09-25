/**
 * The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
 * It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
 *
 * This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
 * a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
 * records, and manage data volume using the LIMIT keyword.
 *
 * Topics covered in this class include:
 * - Understanding the structure of a SOQL query.
 * - Crafting basic SELECT statements in SOQL.
 * - Applying filters using the WHERE clause in SOQL.
 * - Fetching related records using Relationship queries.
 * - Controlling the amount of data retrieved using the LIMIT keyword.
 *
 * Users of this class can expect to gain a solid understanding of SOQL in Apex and
 * be prepared to handle data retrieval tasks in Salesforce development.
 *
 * @author Amy Ho
 */

public with sharing class SOQL {
	/**
	 * Question 1
	 * Update/Uncomment the template code to create a method
	 * Returns all leads from Salesforce Org
	 * @return List of all leads with Id, LastName, Company, Phone, Email
	 * Update the corresponding test class and testGetAllLeads method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	public static List<Lead> getAllLeads(){
		List<Lead> result  = new List<Lead>();
		result = [SELECT Id, LastName, Company, Phone, Email FROM Lead];
		return result;
	}

	/**
	 * Question 2
	 * Update/Uncomment the template code to create a method
	 * Returns all contacts with first name of John.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByFirstName method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static List<Contact> getContactsByFirstName(){
		List<Contact> result = new List<Contact>();
		result = [SELECT Id, Name, FirstName FROM Contact WHERE FirstName = 'John'];
		return result;
	}


	/**
	 * Question 3
	 * Update/Uncomment the template code to create a method
	 * Returns the Contact Id for all contacts with last name of Smith or Jones
	 * @return A list of Contact Ids.
	 * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static List<Id> getContactIdsByLastName(){
		List<Id> result = new List<Id>();
		Map<Id,Contact> myContactsMap = new Map<Id,Contact>();

		myContactsMap = new Map<Id,Contact>([SELECT Id, Name, LastName FROM Contact 
							WHERE LastName = 'Smith' OR LastName = 'Jones']);
		result.addAll( myContactsMap.keySet() );
		return result;
}
	/**
	 * Question 4
	 * Update/Uncomment the template code to create a method
	 * Returns List of closed won opportunities for a specific Account.
	 * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Opportunities with important opportunities fields
	 * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static List<Opportunity> getClosedWonOpportunityCountByAccount(String accountId){
		List<Opportunity> result = new List<Opportunity>();

		result = [SELECT Id, AccountId, Name, StageName, CloseDate, Amount FROM Opportunity 
					WHERE StageName = 'Closed Won' AND AccountId = :accountId];
		return result;
	}


	/**
	 * Question 5
	 * Update/Uncomment the template code to create a method
	 * Returns the total count of Account records.
	 * @return The Integer count of Account records.
	 * Update the corresponding test class and testGetAccountCount method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static Integer getAccountCount(){

		return [SELECT COUNT() FROM Account];

	}
	/**
	 * Question 6
	 * Update/Uncomment the template code to create a method
	 * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
	 * @return A map of Task Ids to Task records.
	 * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static Map<Id,Task> getTasksDueNextWeek(){
		Map<Id,Task> result = new Map<Id,Task> ();
		result = new Map<Id,Task> ( [SELECT Id, Subject, ActivityDate FROM Task 
										WHERE ActivityDate <= NEXT_N_DAYS:7] );
		return result;
	}


	/**
	 * Question 7
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Contacts that have a example.com domain in their Email.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static List<Contact> getContactsByEmailDomain(){
		List<Contact> result = new List<Contact>();
		result = [SELECT Id, Name, Email FROM Contact WHERE Email LIKE '%example.com'];
		return result;
	}


	/**
	 * Question 8
	 * Retrieves all Opportunities that have a specific keyword in their Name.
	 * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
	 * @param keyword The keyword to search for in the Opportunity Name.
	 * @return A list of Opportunity records.
	 */
	public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
		List<Opportunity> result = new List<Opportunity>();
		String keyMatch = '%' + keyword + '%';
		result = [SELECT Id, Name FROM Opportunity WHERE Name LIKE :keyMatch];
		return result; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 9
	 * Retrieves all Cases that Case Origin is not Web or Email or Blank
	 * @return A list of Case records.
	 */
	public static List<Case> getFilterCaseOrigins() {

		List<Case> result = new List<Case>();
		result = [SELECT Id, Origin, Subject FROM Case WHERE Origin NOT IN ('Web', 'Email') AND Origin != null];
		return result; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 10
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
	 * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
	 * @param leadSource The Lead Source to search for.
	 * @param keyword The keyword to search for in the Lead Title.
	 * @return A list of Lead records.
	 * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static List<Lead> getLeadsBySourceOrTitle(String leadSource, String keyword){
		List<Lead> result = new List<Lead>();
		String keyMatch = '%' + keyword + '%';
		result = [SELECT Id, LeadSource, Title, LastName, Phone, Email, Company FROM Lead 
		WHERE LeadSource =:leadSource OR Title LIKE :keyMatch];
		return result;
	}

	/**
	 * Question 11
	 * Returns the names of all Contacts associated with an Account.
	 * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Contact LastName.
	 */
	public static List<String> getContactNamesByAccount(Id accountId) {

		List<Contact> myContacts = new List<Contact>();
		List<String> result = new List<String>();
		myContacts = [SELECT Id, LastName, AccountId FROM Contact 
							WHERE AccountId = :accountId ORDER BY LastName ASC];
		for(Contact con : myContacts){
			result.add(con.LastName);
		}
		return result;
		 	
	}

	/**
	 * Question 12
	 * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
	 * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for the found opportunities
	 * @param stage The Stage value to filter Opportunities.
	 * @return The total revenue.
	 */
	public static Decimal getTotalRevenueByStage(String stage) {
		// Use AggregateQuery to get the total revenue
		Decimal result = 0;
		List<AggregateResult> ar = [SELECT SUM(Amount) totalRevenue FROM Opportunity 
						WHERE StageName = :stage OR Amount > 10000];
		result = (Decimal) ar.get(0).get('totalRevenue');
		// Return the total revenue
		return result; 
	}

	/**
	 * Question 13
	 * Retrieves the first 10 Accounts ordered by Name.
	 * @return A list of the first 10 Accounts ordered by Name.
	 */
	public static List<Account> getFirstTenAccounts() {
		List<Account> result = new List<Account>();
		result = [SELECT Id, Name FROM Account ORDER BY Name ASC LIMIT 10];
		return result; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 14
	 * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 */
	public static List<Opportunity> getHighValueOpportunities() {
		List<Opportunity> result = new List<Opportunity>();

		result = [SELECT Id, Name, Amount, CloseDate FROM Opportunity 
						WHERE Amount > 100000 ORDER BY CloseDate ASC LIMIT 5];

		return result; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 15
	 * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
	 * @return A list of Contacts
	 */
	public static List<Contact> getBirthdateContacts() {
		List<Contact> result = new List<Contact>();

		result = [SELECT Id, Name, Birthdate FROM Contact 
						WHERE Birthdate != null ORDER BY Birthdate DESC LIMIT 3];

		return result; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 16
	 * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
	 * @return A list of Cases
	 */
	public static List<Case> getCasesWithStatus() {
		List<Case> result = new List<Case>();

		result = [SELECT Id, Status, CreatedDate FROM Case 
						WHERE Status = 'Open' ORDER BY CreatedDate ASC LIMIT 10 OFFSET 5];

		return result; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 17
	 * Returns Set of Case Ids for a specific Account.
	 * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A set of Case Ids.
	 */
	public static Set<Id> getCaseIdsByAccount(Id accountId) {
		// Create a set to hold the Case Ids
		Set<Id> caseIds = new Set<Id>();
		Map<Id,Case> myCasesMap = new Map<Id,Case>();

		myCasesMap = new Map<Id,Case>([SELECT Id, AccountId, Subject FROM Case 
							WHERE AccountId = :accountId]);	
		caseIds = myCasesMap.keySet();	

		return caseIds; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 18
	 * Return Map of Account Ids to Account Names Not in a specific Country.
	 * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
	 * @param country The country to filter Accounts.
	 * @return A map of Account Ids to Account Names.
	 */
	public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
		// Create a map to hold the Account Ids to Account Names
		Map<Id, String> accountIdsToNames = new Map<Id, String>();

		List<Account> acctList = [SELECT Id, Name, BillingCountry FROM Account 
							WHERE BillingCountry != :country];

		for(Account acct : acctList){
			accountIdsToNames.put(acct.Id, acct.Name);
		}

		return accountIdsToNames; 
	}

	/**
	 * Question 19
	 * Retrieves the Account Name for a given Contact.
	 * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
	 * @param contactId The Id of the Contact.
	 * @return The Account Name of the Contact.
	 */
	public static String getAccountNameForContact(String contactId) {
		Contact con = [SELECT Id, Name, Account.Name FROM Contact WHERE Id = :contactId LIMIT 1];

		return con.Account.Name; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 20
	 * Returns single Account that has related opportunities in the same query
	 * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
	 * @param accountId The ID of the Account.
	 * @return An Account record with related Opportunities.
	 */
	public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
		Account acct = new Account();
		acct = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities) 
					FROM Account WHERE Id = :accountId LIMIT 1];
		return acct; 
	}

	/**
	 * Question 21
	 * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
	 * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
	 * @param Account Id
	 * @return List of contacts with the same Mailing State as the Account Billing State
	 */
	public static List<Contact> getAccountsWithContactsByState(Id accountId) {
		List<Contact> contactList = new List<Contact>();
		
		Account acct = [SELECT Id, BillingState FROM Account 
		WHERE Id = :accountId LIMIT 1];

		contactList = [SELECT Id, Name, MailingState, Account.BillingState FROM Contact 
						WHERE MailingState != null AND Account.BillingState != null 
						AND MailingState = :acct.BillingState];

		return contactList; 
	}

	/**
	 * Question 22
	 * Extracts email domains from them leads, then finds Accounts with matching website domains
	 * If Lead Email = test@test.com return account with website = www.test.com
	 * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
	 * @param A set of Lead Ids.
	 * @return A list of Accounts with matching email domains.
	 */
	public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
		List<Lead> leadList = new List<Lead>();
		Set<String> emailDomains = new Set<String>();
		Map<String, Account> domainToAccountMap = new Map<String, Account>();
		List<Account> accountList = new List<Account>();
		List<Account> result = new List<Account>();

		// Query the Leads
		leadList = [SELECT Id, Email FROM Lead WHERE Id IN :leadIds];

		// Create a set of email domains from the Leads
		// Loop through each Lead
		// Get the email from the Lead
		// Check if the email is not null and contains '@'
		// Add the email domain to the set
		for(Lead lead : leadList) {
			if(lead.Email != null && lead.Email.contains('@')) {
				String emailDomain = lead.Email.substringAfter('@');
				emailDomains.add(emailDomain);
			}
		}
		// Query Accounts where website not null 
		accountList = [SELECT Id, Name, Website FROM Account WHERE Website != null];

		// Create a map of email domains to Accounts
		for(Account acct : accountList){
			String websiteDomain = acct.Website.substringAfter('www.');
			domainToAccountMap.put(websiteDomain, acct);
		}

		// Loop through each email domain
		for(String emailDomain : emailDomains) {
			// Check if the email domain is in the map emailDomains
			// If it is, add the Account to the result list			
			if(domainToAccountMap.containsKey(emailDomain)) {
				Account acct = domainToAccountMap.get(emailDomain);
				result.add(acct);
			}
		}

		return result; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 23
	 * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
	 * Adds a randomized number between 1 to 3 to the quantity of each line item.
	 * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
	 * @param Original Opportunity Id
	 * @param List of cloned Opportunity Ids
	 */
	public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {

		List<OpportunityLineItem> origLineItems = new List<OpportunityLineItem>();
		
		// Query the original Opportunity Line Items
		origLineItems = [SELECT Id, Quantity, UnitPrice, PricebookEntryId, OpportunityId FROM OpportunityLineItem 
						WHERE OpportunityId = :origOppId];	

		// Create a list to hold the new line items
		List<OpportunityLineItem> newLineItems = new List<OpportunityLineItem>();

		// Generate a random number between 1 and 3
		Integer quantity = Integer.valueOf(Math.floor(Math.random() * 3) + 1);	

		// Loop through Set of cloned Opportunity Id
		for(Id cloneOppId : cloneOppIds) {

			// Loop through all original line item
			for(OpportunityLineItem origLineItem : origLineItems) {

				// Clone the original line item and add the random number to the quantity
				OpportunityLineItem newLineItem = origLineItem.clone(false, true, false, false);
				newLineItem.OpportunityId = cloneOppId;
				newLineItem.Quantity = quantity;
				newLineItems.add(newLineItem);
			}
		}
		// Insert the new line items
	 	insert newLineItems;
	}

	/**
	 * Question 24
	 * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
	 * @return A list of filtered Opportunity
	 */
	public static List<Opportunity> getOpportunityDetailsForClosedWon() {

		List<Opportunity> result = new List<Opportunity>();
		result = [SELECT Id, Name, Account.Name, Owner.Name FROM Opportunity 
					WHERE StageName = 'Closed Won'];
		return result; 
	}

	/**
	 * Question 25
	 * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to the Contact on the associated Account with the alphabetically first first name.
	 * Example: if there are two Contacts on the Account, "Billy" and "Abby," the 'Primary_Contact__c' will be set to "Abby."
	 */
	public static void setPrimaryContact() {
		//Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
		List<Opportunity> oppWonList = getOpportunityDetailsForClosedWon();

		// Create a set of Account Ids from the Opportunities

		// Query the Contacts

		// Loop through each Contact and add the Account Id and Contact to the map

		// Loop through each Opportunity

		// Update the Opportunity primary contact from accountToContactMap

		// Update the Opportunities
	}
}
