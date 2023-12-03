package entity;

import java.util.List;

public class ImportCoupon { // phieu nhap
	private int idImportCoupon;
	private Supplier supplier;
	private String date;
	private String status;
	private List<DetailImportCoupon> DetailImportCoupons;

	public ImportCoupon(int idImportCoupon, Supplier supplier, String date, String status,
			List<DetailImportCoupon> detailImportCoupons) {
		super();
		this.idImportCoupon = idImportCoupon;
		this.supplier = supplier;
		this.date = date;
		this.status = status;
		DetailImportCoupons = detailImportCoupons;
	}

	public ImportCoupon(int idImportCoupon, Supplier supplier, String date, String status) {
		super();
		this.idImportCoupon = idImportCoupon;
		this.supplier = supplier;
		this.date = date;
		this.status = status;
	}

	@Override
	public String toString() {
		return "ImportCoupon [idImportCoupon=" + idImportCoupon + ", supplier=" + supplier + ", date=" + date
				+ ", status=" + status + "]";
	}

	public int getIdImportCoupon() {
		return idImportCoupon;
	}

	public void setIdImportCoupon(int idImportCoupon) {
		this.idImportCoupon = idImportCoupon;
	}

	public List<DetailImportCoupon> getDetailImportCoupons() {
		return DetailImportCoupons;
	}

	public void setDetailImportCoupons(List<DetailImportCoupon> detailImportCoupons) {
		DetailImportCoupons = detailImportCoupons;
	}

	public Supplier getSupplier() {
		return supplier;
	}

	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
