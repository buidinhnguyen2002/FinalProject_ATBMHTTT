package util;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.*;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class API {
    private static final String loginAPI_url = "http://140.238.54.136/api/auth/login";
    private static final String registerAPI_url = "http://140.238.54.136/api/auth/register";

    private static final String changePassAPI_url = "http://140.238.54.136/api/auth/change_pass";

    private static final String seenAccount_url = "http://140.238.54.136/api/auth/me";

    private static final String province_url = "http://140.238.54.136/api/province";

    private static final String district_url = "http://140.238.54.136/api/district";

    private static final String ward_url = "http://140.238.54.136/api/ward";

    private static final String leadTime_url = "http://140.238.54.136/api/leadTime";

    private static final String shipFee_url = "http://140.238.54.136/api/calculateFee";

    private static final String registerTransport_url = "http://140.238.54.136/api/registerTransport";

    private static final String allTransports_url = "http://140.238.54.136/api/allTransports";

    private static final String getTransportsByID_url = "http://140.238.54.136/api/auth/getInfoTransport";

    public static String registerAPI(String name, String email, String password, String passwordConfirmation) throws IOException {
        URL url = new URL(registerAPI_url);

        HttpURLConnection connect = (HttpURLConnection) url.openConnection();
        connect.setRequestMethod("POST");
        connect.setDoOutput(true);
        connect.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

        Map<String, String> paramesters = new HashMap<>();
        paramesters.put("name", name);
        paramesters.put("email", email);
        paramesters.put("password", password);
        paramesters.put("password_confirmation", passwordConfirmation);

        OutputStreamWriter writer = new OutputStreamWriter(connect.getOutputStream());
        writer.write(getFormUrlEnCodedData(paramesters));
        writer.flush();

        return getString(connect);
    }

    private static String getFormUrlEnCodedData(Map<String, String> paramesters) {
        StringBuilder stringBuilder = new StringBuilder();
        for (Map.Entry<String, String> entry : paramesters.entrySet()) {
            stringBuilder.append(entry.getKey());
            stringBuilder.append("=");
            stringBuilder.append(entry.getValue());
            stringBuilder.append("&");
        }
        String formData = stringBuilder.toString();
        if (formData.endsWith("&")) {
            formData = formData.substring(0, formData.length() - 1);
        }
        return formData;
    }

    public static String loginAPI(String email, String password) throws IOException {
        URL url = new URL(loginAPI_url);

        HttpURLConnection connect = (HttpURLConnection) url.openConnection();
        connect.setRequestMethod("POST");
        connect.setDoOutput(true);
        connect.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

        Map<String, String> parameters = new HashMap<>();
        parameters.put("email", email);
        parameters.put("password", password);

        OutputStreamWriter writer = new OutputStreamWriter(connect.getOutputStream());
        writer.write(getFormUrlEnCodedDataLogin(parameters));
        writer.flush();

        return getString(connect);
    }

    private static String getString(HttpURLConnection connect) throws IOException {

        int statusCode = connect.getResponseCode();
        BufferedReader reader;
        if (statusCode >= 200 && statusCode < 300) {
            reader = new BufferedReader(new InputStreamReader(connect.getInputStream()));
        } else {
            reader = new BufferedReader(new InputStreamReader(connect.getErrorStream()));
        }

        StringBuilder stringBuilder = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            stringBuilder.append(line);
        }
        reader.close();
        connect.disconnect();

        return stringBuilder.toString();
    }

    private static String getFormUrlEnCodedDataLogin(Map<String, String> paramesters) {
        StringBuilder stringBuilder = new StringBuilder();
        for (Map.Entry<String, String> entry : paramesters.entrySet()) {
            stringBuilder.append(entry.getKey());
            stringBuilder.append("=");
            stringBuilder.append(entry.getValue());
            stringBuilder.append("&");
        }
        return stringBuilder.toString();
    }

    public static String changePass(String oldPass, String newPass, String newPassConfirmation) throws IOException {
        URL url = new URL(changePassAPI_url);

        HttpURLConnection connect = (HttpURLConnection) url.openConnection();
        connect.setRequestMethod("POST");
        connect.setRequestProperty("Authorization", "Bearer" + getToken());
        connect.setDoOutput(true);

        String requestBody = "old_password=" + oldPass + "&new_password=" + newPass + "&new_password_confirmation=" + newPassConfirmation;

        OutputStream os = connect.getOutputStream();
        OutputStreamWriter writer = new OutputStreamWriter(os);
        writer.write(requestBody);
        writer.flush();

        return getString(connect);
    }

    public static String getToken() throws IOException {
        String input = loginAPI("rynvia1522@gmail.com", "thuyhao1234");
        int star = input.indexOf("\"") + 16;
        int end = input.indexOf("\"", star);
        return input.substring(star, end);
    }

    public static String seenAccount() throws IOException {
        URL url = new URL(seenAccount_url);

        HttpURLConnection connect = (HttpURLConnection) url.openConnection();
        connect.setRequestMethod("POST");
        connect.setDoOutput(true);
        connect.setRequestProperty("Authorization", "Bearer" + getToken());

        return getString(connect);
    }

//    public static ArrayList<Province> getProvinces() throws IOException {
//        URL url = new URL(province_url);
//        HttpURLConnection connect = (HttpURLConnection) url.openConnection();
//        connect.setRequestMethod("GET");
//        connect.setDoOutput(true);
//        connect.setRequestProperty("Authorization", "Bearer" + getToken());
//        String json = getString(connect);
//        Gson gson = new Gson();
//        JSONObject jsonObject = new JSONObject(json);
//        JSONArray data = jsonObject.getJSONObject("original").getJSONArray("data");
//        Type listType = new TypeToken<ArrayList<Province>>() {}.getType();
//        ArrayList<Province> provinces = gson.fromJson(data.toString(), listType);
//        return provinces;
//    }
//    public static String getProvince() throws IOException {
//        URL url = new URL(province_url);
//
//        HttpURLConnection connect = (HttpURLConnection) url.openConnection();
//        connect.setRequestMethod("GET");
//        connect.setDoOutput(true);
//        connect.setRequestProperty("Authorization", "Bearer" + getToken());
//
//        return getString(connect);
//    }
//    public static ArrayList<District> getDistricts(String param) throws IOException {
//        try {
//            String line = district_url + "?provinceID=" + param;
//            String connect = connect(line);
//            if (connect != null) {
//                Gson gson = new Gson();
//                JSONObject jsonObject = new JSONObject(connect);
//                JSONArray data = jsonObject.getJSONObject("original").getJSONArray("data");
//                Type listType = new TypeToken<ArrayList<District>>() {}.getType();
//                ArrayList<District> districts = gson.fromJson(data.toString(), listType);
//                return  districts;
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return null;
//    }
//
//    public static ArrayList<Ward> getWards(String param){
//        try {
//            String line = ward_url + "?districtID=" + param;
//            String connect = connect(line);
//            if (connect != null) {
//                Gson gson = new Gson();
//                JSONObject jsonObject = new JSONObject(connect);
//                JSONArray data = jsonObject.getJSONObject("original").getJSONArray("data");
//                Type listType = new TypeToken<ArrayList<Ward>>() {}.getType();
//                ArrayList<Ward> wards = gson.fromJson(data.toString(), listType);
//                return  wards;
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return null;
//    }

    private static String connect(String line) throws IOException {
        URL url = new URL(line);

        HttpURLConnection connect = (HttpURLConnection) url.openConnection();
        connect.setRequestMethod("GET");
        connect.setDoOutput(true);
        connect.setRequestProperty("Authorization", "Bearer" + getToken());

        int responseCode = connect.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
            return getString(connect);
        } else {
            System.out.println("Lỗi " + responseCode + ": " + connect.getResponseMessage());
        }
        return null;
    }

    public static String leadTime(String fromDistrictID, String fromWardID, String toDistrictID, String toWardID, String height, String length, String width, String weight) throws IOException {
        return connection(fromDistrictID, fromWardID, toDistrictID, toWardID, height, length, width, weight, leadTime_url);
    }

    public static String registerTransport(String fromDistrictID, String fromWardID, String toDistrictID, String toWardID, String height, String length, String width, String weight) throws IOException {
        return connection(fromDistrictID, fromWardID, toDistrictID, toWardID, height, length, width, weight, registerTransport_url);
    }

    public static String feeShip(String fromDistrictID, String fromWardID, String toDistrictID, String toWardID, String height, String length, String width, String weight) throws IOException {
        return connection(fromDistrictID, fromWardID, toDistrictID, toWardID, height, length, width, weight, shipFee_url);
    }

    private static String connection(String fromDistrictID, String fromWardID, String toDistrictID, String toWardID, String height, String length, String width, String weight, String geturl) throws IOException {
        URL url = new URL(geturl);

        HttpURLConnection connect = (HttpURLConnection) url.openConnection();
        connect.setRequestMethod("POST");
        connect.setDoOutput(true);
        connect.setRequestProperty("Authorization", "Bearer" + getToken());

        Map<String, String> getTime = new HashMap<>();
        getTime.put("from_district_id", fromDistrictID);
        getTime.put("from_ward_id", fromWardID);
        getTime.put("to_district_id", toDistrictID);
        getTime.put("to_ward_id", toWardID);
        getTime.put("height", height);
        getTime.put("length", length);
        getTime.put("width", width);
        getTime.put("weight", weight);

        OutputStreamWriter writer = new OutputStreamWriter(connect.getOutputStream());
        writer.write(getFormUrlEnCodedDataLogin(getTime));
        writer.flush();

        return getString(connect);
    }

    public static String getAllTransports() throws IOException {
        URL url = new URL(allTransports_url);

        HttpURLConnection connect = (HttpURLConnection) url.openConnection();
        connect.setRequestMethod("GET");
        connect.setDoOutput(true);
        connect.setRequestProperty("Authorization", "Bearer" + getToken());

        return getString(connect);
    }

    // đang bug :((
    public static String getTransportByID(String id) throws IOException {
            URL url = new URL(getTransportsByID_url);

            HttpURLConnection connect = (HttpURLConnection) url.openConnection();
            connect.setRequestMethod("POST");
            connect.setDoOutput(true);
            connect.setRequestProperty("Authorization", "Bearer" + getToken());

            Map<String, String> parameters = new HashMap<>();
            parameters.put("id", id);

            OutputStreamWriter writer = new OutputStreamWriter(connect.getOutputStream());
            writer.write(getFormUrlEnCodedDataLogin(parameters));
            writer.flush();

        return getString(connect);
    }

    public static void main(String[] args) throws IOException {
//        System.out.println(registerAPI("RynVia", "rynvia1522@gmail.com", "thuyhao", "thuyhao"));
//        System.out.println(loginAPI("rynvia1522@gmail.com", "thuyhao1234"));
//        System.out.println(changePass("thuyhao123", "thuyhao1234", "thuyhao1234"));
//        System.out.println(getToken());
//        System.out.println(getProvinces());
//        System.out.println(getProvince());
//        System.out.println(getDistricts("269"));
//        System.out.println(getWards("2264"));
//        System.out.println(leadTime("2264", "90816", "2270", "231013", "100", "100", "50", "100"));
        System.out.println(feeShip("2264", "90816", "2270", "231013", "20", "20", "20", "100"));
//        System.out.println(getAllTransports());
//        System.out.println(getTransportByID("0acf5c34e5c24a87b36c80491f04a7f3"));
    }
}
