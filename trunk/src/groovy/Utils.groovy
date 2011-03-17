class Utils {

    static String getBaseAppUrl(String url, String controller) {
        int end = url.indexOf("/grails/");
        if (end < 0)
            end = url.indexOf("/"+controller)
        return url.substring(0, end);
    }
    
    static String formatTimeFrame(Integer startTime, Integer endTime) {
                String prettyStart = "";
        String startAmPm = "";
        if (startTime != null) {
            prettyStart = getPrettyTime(startTime)
            startAmPm = getAmPm(startTime)
        }

        String prettyEnd = "";
        String endAmPm = ""
        if (endTime != null) {
            prettyEnd = " - "+getPrettyTime(endTime)
            endAmPm = getAmPm(endTime)
        }

        return startAmPm != endAmPm ?
            prettyStart+" "+startAmPm+prettyEnd+" "+endAmPm :
            prettyStart+prettyEnd+" "+endAmPm
    }

    static String getAmPm(long number) {
        return number >= 1200 ? "PM" : "AM";
    }

    static String getPrettyTime(long number) {
        String minutes = String.valueOf((int)((number%100)/100.0*60))
        int hours = (number/100)
        hours = hours%12
        if (hours > 1200)
            hours -= 1200
        if (hours == 0)
            hours = 12

        return String.valueOf(hours)+":"+minutes.padRight(2, "0")
    }

  static String fixUpCaps(String name) {
      name.substring(0, 1).toUpperCase()+name.toLowerCase().substring(1)
  }
}