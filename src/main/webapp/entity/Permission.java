package entity;

public class Permission {
    private Long id;
    private int idRole;
    private Resource resource;
    private int idResource;
    private String action;

    public Permission() {
    }

    public Permission(Long id, Resource resource, String action) {
        this.id = id;
        this.resource = resource;
        this.action = action;
    }

    public Permission(Long id, int idRole, Resource resource, String action) {
        this.id = id;
        this.idRole = idRole;
        this.resource = resource;
        this.action = action;
    }

    public int getIdRole() {
        return idRole;
    }

    public void setIdRole(int idRole) {
        this.idRole = idRole;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Resource getResource() {
        return resource;
    }

    public void setResource(Resource resource) {
        this.resource = resource;
    }

    public int getIdResource() {
        return idResource;
    }

    public void setIdResource(int idResource) {
        this.idResource = idResource;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    @Override
    public String toString() {
        return "Permission{" +
                "id=" + id +
                ", idRole=" + idRole +
                ", resource=" + resource +
                ", idResource=" + idResource +
                ", action='" + action + '\'' +
                '}';
    }
}