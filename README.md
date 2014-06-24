OTPersonalData
==============

Simple instantiate screens with data validation

How to get
==============

Simply clone this to your project

How to use
==============
You need to create config with data fields first:
<pre><code>
OTPersonalDataConfig *contactsDataConfig = [[OTPersonalDataConfig alloc] init];
contactsDataConfig.type = @"contacts"; // Give it identifier
contactsDataConfig.title = NSLocalizedString(@"Customer Info", nil); //Give it a title
</code></pre>
Then you need to create some fields:
<pre><code>
// Email
OTFieldConfig *emailConfig = [[OTFieldConfig alloc] initWithTitle:NSLocalizedString(@"Email", nil) subtitle:@"" placeHolder:@"your@mail.com"]; // create field
OTEmailModifier *emailModifier = [[OTEmailModifier alloc] init]; //create a modifier for this field
OTEmailValidator *emailValidator = [[OTEmailValidator alloc] init]; //create a validator
emailConfig.key = @"email"; //set an identifier for this field
emailConfig.modifier = emailModifier; //set modifier
emailConfig.validator = emailValidator; //set validator

// Same for phone field
// Phone
OTFieldConfig *phoneConfig = [[OTFieldConfig alloc] initWithTitle:NSLocalizedString(@"Phone", nil) subtitle:NSLocalizedString(@"Phone number", nil) placeHolder:@"380501234567"];
OTTelephoneModifier *phoneModifier = [[OTTelephoneModifier alloc] init];
OTEmptyValidator *phoneValidator = [[OTEmptyValidator alloc] init];
phoneConfig.key = @"telephone";
phoneConfig.modifier = phoneModifier;
phoneConfig.validator = phoneValidator;
</code></pre>
Next set this feilds to the config:
<code><pre>
contactsDataConfig.fields = @[emailConfig, phoneConfig];
</code></pre>
Create a OTPersonalDataViewController:
<pre><code>
//Create VC
OTPersonalDataViewController *vc = [[OTPersonalDataViewController alloc] initWithNibName:@"OTPersonalDataViewController" bundle:[NSBundle mainBundle]];

//Set config to VC
NSArray *config = @[contactsDataConfig];
[vc setConfig:config];
</code></pre>

All personal data will be saved after validation.
Good Luck. 

