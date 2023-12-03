package controller.admin.webSocket;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import javax.websocket.OnClose;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

@ServerEndpoint(value = "/observer")

public class UpdateAccountEndPoint {
    // Danh sách các session đang kết nối
    private static Set<Session> sessions = Collections.synchronizedSet(new HashSet<>());

    @OnOpen
    public void onOpen(Session session) throws IOException {
        // Thêm session mới vào danh sách
        sessions.add(session);
    }

    @OnClose
    public void onClose(Session session) throws IOException {
        // Xóa session khỏi danh sách
        sessions.remove(session);
    }

    public static void  notifyUserUpdate(int idUser,String type) throws IOException {
        // Tạo thông báo cho client
        Gson gson = new Gson();
        JsonObject main = new JsonObject();
        main.addProperty("idUser",idUser);
        main.addProperty("type",type);
        // Gửi thông báo đến tất cả các session đang kết nối
        for (Session session : sessions) {
            if (session.isOpen()) {
                session.getBasicRemote().sendText(gson.toJson(main));
            }
        }
    }
}
