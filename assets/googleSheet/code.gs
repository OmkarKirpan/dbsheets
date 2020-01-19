  var SHEET_NAME = "Products";
  var OSHEET_NAME = "Orders";

var SCRIPT_PROP = PropertiesService.getScriptProperties();

function doGet(e){
  return handleResponse(e);
}

function doPost(e){
  return handleResponse(e);
}

function handleResponse(e) {
    var lock = LockService.getPublicLock();
  lock.waitLock(30000);  // wait 30 seconds before conceding defeat.

  try {
    var labels=new Array;
    if(e.parameter.action === "order"){
      labels.push(["hi"]);
      labels = setData(e);
    }
    if(e.parameter == '' || e.parameter.action === "get"){
      labels = getData();
    }
//    labels = getData(data);
   
       return ContentService
          .createTextOutput(JSON.stringify({"result":"success", "row": labels, "rewq": e}))
          .setMimeType(ContentService.MimeType.JSON);
  } catch(e){
    // if error return this
    return ContentService
          .createTextOutput(JSON.stringify({"result":"error", "error": e}))
          .setMimeType(ContentService.MimeType.JSON);
  } finally { //release lock
    lock.releaseLock();
  }
}

function setup() {
    var doc = SpreadsheetApp.getActiveSpreadsheet();
    SCRIPT_PROP.setProperty("key", doc.getId());
}

function getData() {
    var doc = SpreadsheetApp.openById(SCRIPT_PROP.getProperty("key"));
    var sheet = doc.getSheetByName("Products");
       
    var nextRow = sheet.getLastRow()+1; // get next row
    var range = sheet.getDataRange();
    var data = range.getValues();


    var row_id = "0";
    var results=new Array;
             // looping through all the data in a sheet 
    for (i in data) {
        // comparing a coloum value with our variable, if matched that row will be retrieved.
      if(i != row_id){
        results.push({
          sku: data[i][0],
          name: data[i][1],
          desc:  data[i][2],
          price: data[i][3]
        });
      }
    }
     return results;
}

function setData(e) {
    var doc = SpreadsheetApp.openById(SCRIPT_PROP.getProperty("key"));
    var sheet = doc.getSheetByName("Orders");

    var headRow = e.parameter.header_row || 1;
    var headers = sheet.getRange(1, 1, 1, sheet.getLastColumn()).getValues()[0];
    var nextRow = sheet.getLastRow()+1; // get next row

    var row = [];
    // loop through the header columns
    for (i in headers){
      if (headers[i] == "Timestamp"){ // special case if you include a 'Timestamp' column
        row.push(new Date());
      } else { // else use header name to get data
        row.push(e.parameter[headers[i]]);
      }
    }
    
     // more efficient to set values as [][] array than individually
    sheet.getRange(nextRow, 1, 1, row.length).setValues([row]);
    
     return nextRow;
}