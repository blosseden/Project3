package model;

public class MyFileDTO {
 
		private String idx; //일련번호
		private String name; //작성자
		private String title; //제목
		private String inter;//관심사항
		private String Ofile;//원본파일명
		private String Sfile; //서버에 저장된 파일명
		private String postdate; //작성일
		
		public String getIdx() {
			return idx;
		}
		public void setIdx(String idx) {
			this.idx = idx;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getInter() {
			return inter;
		}
		public void setInter(String inter) {
			this.inter = inter;
		}
		public String getOfile() {
			return Ofile;
		}
		public void setOfile(String ofile) {
			this.Ofile = ofile;
		}
		public String getSfile() {
			return Sfile;
		}
		public void setSfile(String sfile) {
			this.Sfile = sfile;
		}
		public String getPostdate() {
			return postdate;
		}
		public void setPostdate(String postdate) {
			this.postdate = postdate;
		}
}