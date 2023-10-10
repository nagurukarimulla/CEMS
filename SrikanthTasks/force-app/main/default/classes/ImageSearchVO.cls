
public with sharing class ImageSearchVO  {
    public String id;
    public String url;
    public Integer height;
    public Integer width;
public static ImageSearchVO parse(String json){
    return (ImageSearchVO) System.JSON.deserialize(json, ImageSearchVO.class);
}
}