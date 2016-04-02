var mongoose = require('mongoose');
mongoose.connect('mongodb://localhost/rome');

var clientSchema = {
	name: { type: String, required: true },
	api_key: { type: String, required: true }
};

var Client = mongoose.model('Client', clientSchema);

var client = new Client({ name: 'Master', api_key: 'fbdc5668-c02f-456d-9e8f-6d02fb8ef490' });
client.save(function (err) {
	if (err) {
		console.log(err);
	} else {
		console.log('Added default seed');
	}
	process.exit();
});