@ReactMethod
private void runModelOnImage(final String path, final float mean, final float std, final int numResults,
                             final float threshold, final Callback callback) throws IOException {

  InputStream inputStream = new FileInputStream(path.replace("file://", ""));
  Bitmap bitmapRaw = BitmapFactory.decodeStream(inputStream);

  if (bitmapRaw == null) {
    callback.invoke("BULL SHIT GOD DAMN!!!", null);
  } else {
    tfLite.run(feedInputTensorImage(path, mean, std), labelProb);
    callback.invoke(null, GetTopN(numResults, threshold));
  }
}
