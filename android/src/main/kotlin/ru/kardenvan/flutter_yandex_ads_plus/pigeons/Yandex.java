// Autogenerated from Pigeon (v1.0.19), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package ru.kardenvan.flutter_yandex_ads_plus.pigeons;

import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

/** Generated class from Pigeon. */
@SuppressWarnings({"unused", "unchecked", "CodeBlock2Expr", "RedundantSuppression"})
public class Yandex {

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class EventRequest {
    private @NonNull String name;
    public @NonNull String getName() { return name; }
    public void setName(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"name\" is null.");
      }
      this.name = setterArg;
    }

    private @NonNull String id;
    public @NonNull String getId() { return id; }
    public void setId(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"id\" is null.");
      }
      this.id = setterArg;
    }

    private @NonNull String type;
    public @NonNull String getType() { return type; }
    public void setType(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"type\" is null.");
      }
      this.type = setterArg;
    }

    /** Constructor is private to enforce null safety; use Builder. */
    private EventRequest() {}
    public static class Builder {
      private @Nullable String name;
      public @NonNull Builder setName(@NonNull String setterArg) {
        this.name = setterArg;
        return this;
      }
      private @Nullable String id;
      public @NonNull Builder setId(@NonNull String setterArg) {
        this.id = setterArg;
        return this;
      }
      private @Nullable String type;
      public @NonNull Builder setType(@NonNull String setterArg) {
        this.type = setterArg;
        return this;
      }
      public @NonNull EventRequest build() {
        EventRequest pigeonReturn = new EventRequest();
        pigeonReturn.setName(name);
        pigeonReturn.setId(id);
        pigeonReturn.setType(type);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("name", name);
      toMapResult.put("id", id);
      toMapResult.put("type", type);
      return toMapResult;
    }
    static @NonNull EventRequest fromMap(@NonNull Map<String, Object> map) {
      EventRequest pigeonResult = new EventRequest();
      Object name = map.get("name");
      pigeonResult.setName((String)name);
      Object id = map.get("id");
      pigeonResult.setId((String)id);
      Object type = map.get("type");
      pigeonResult.setType((String)type);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class EventResponse {
    private @Nullable String data;
    public @Nullable String getData() { return data; }
    public void setData(@Nullable String setterArg) {
      this.data = setterArg;
    }

    private @Nullable Long code;
    public @Nullable Long getCode() { return code; }
    public void setCode(@Nullable Long setterArg) {
      this.code = setterArg;
    }

    private @Nullable String description;
    public @Nullable String getDescription() { return description; }
    public void setDescription(@Nullable String setterArg) {
      this.description = setterArg;
    }

    public static class Builder {
      private @Nullable String data;
      public @NonNull Builder setData(@Nullable String setterArg) {
        this.data = setterArg;
        return this;
      }
      private @Nullable Long code;
      public @NonNull Builder setCode(@Nullable Long setterArg) {
        this.code = setterArg;
        return this;
      }
      private @Nullable String description;
      public @NonNull Builder setDescription(@Nullable String setterArg) {
        this.description = setterArg;
        return this;
      }
      public @NonNull EventResponse build() {
        EventResponse pigeonReturn = new EventResponse();
        pigeonReturn.setData(data);
        pigeonReturn.setCode(code);
        pigeonReturn.setDescription(description);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("data", data);
      toMapResult.put("code", code);
      toMapResult.put("description", description);
      return toMapResult;
    }
    static @NonNull EventResponse fromMap(@NonNull Map<String, Object> map) {
      EventResponse pigeonResult = new EventResponse();
      Object data = map.get("data");
      pigeonResult.setData((String)data);
      Object code = map.get("code");
      pigeonResult.setCode((code == null) ? null : ((code instanceof Integer) ? (Integer)code : (Long)code));
      Object description = map.get("description");
      pigeonResult.setDescription((String)description);
      return pigeonResult;
    }
  }

  public interface Result<T> {
    void success(T result);
    void error(Throwable error);
  }
  private static class YandexAdsApiCodec extends StandardMessageCodec {
    public static final YandexAdsApiCodec INSTANCE = new YandexAdsApiCodec();
    private YandexAdsApiCodec() {}
    @Override
    protected Object readValueOfType(byte type, ByteBuffer buffer) {
      switch (type) {
        case (byte)128:         
          return EventRequest.fromMap((Map<String, Object>) readValue(buffer));
        
        case (byte)129:         
          return EventResponse.fromMap((Map<String, Object>) readValue(buffer));
        
        default:        
          return super.readValueOfType(type, buffer);
        
      }
    }
    @Override
    protected void writeValue(ByteArrayOutputStream stream, Object value)     {
      if (value instanceof EventRequest) {
        stream.write(128);
        writeValue(stream, ((EventRequest) value).toMap());
      } else 
      if (value instanceof EventResponse) {
        stream.write(129);
        writeValue(stream, ((EventResponse) value).toMap());
      } else 
{
        super.writeValue(stream, value);
      }
    }
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter.*/
  public interface YandexAdsApi {
    @NonNull void initialize();
    void onAdLoaded(EventRequest request, Result<EventResponse> result);
    void onAdFailedToLoad(EventRequest request, Result<EventResponse> result);
    void onImpression(EventRequest request, Result<EventResponse> result);
    void onAdClicked(EventRequest request, Result<EventResponse> result);
    void onLeftApplication(EventRequest request, Result<EventResponse> result);
    void onReturnedToApplication(EventRequest request, Result<EventResponse> result);
    void onAdShown(EventRequest request, Result<EventResponse> result);
    void onAdDismissed(EventRequest request, Result<EventResponse> result);

    /** The codec used by YandexAdsApi. */
    static MessageCodec<Object> getCodec() {
      return YandexAdsApiCodec.INSTANCE;
    }

    /** Sets up an instance of `YandexAdsApi` to handle messages through the `binaryMessenger`. */
    static void setup(BinaryMessenger binaryMessenger, YandexAdsApi api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.YandexAdsApi.initialize", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              api.initialize();
              wrapped.put("result", null);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.YandexAdsApi.onAdLoaded", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              EventRequest requestArg = (EventRequest)args.get(0);
              if (requestArg == null) {
                throw new NullPointerException("requestArg unexpectedly null.");
              }
              Result<EventResponse> resultCallback = new Result<EventResponse>() {
                public void success(EventResponse result) {
                  wrapped.put("result", result);
                  reply.reply(wrapped);
                }
                public void error(Throwable error) {
                  wrapped.put("error", wrapError(error));
                  reply.reply(wrapped);
                }
              };

              api.onAdLoaded(requestArg, resultCallback);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
              reply.reply(wrapped);
            }
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.YandexAdsApi.onAdFailedToLoad", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              EventRequest requestArg = (EventRequest)args.get(0);
              if (requestArg == null) {
                throw new NullPointerException("requestArg unexpectedly null.");
              }
              Result<EventResponse> resultCallback = new Result<EventResponse>() {
                public void success(EventResponse result) {
                  wrapped.put("result", result);
                  reply.reply(wrapped);
                }
                public void error(Throwable error) {
                  wrapped.put("error", wrapError(error));
                  reply.reply(wrapped);
                }
              };

              api.onAdFailedToLoad(requestArg, resultCallback);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
              reply.reply(wrapped);
            }
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.YandexAdsApi.onImpression", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              EventRequest requestArg = (EventRequest)args.get(0);
              if (requestArg == null) {
                throw new NullPointerException("requestArg unexpectedly null.");
              }
              Result<EventResponse> resultCallback = new Result<EventResponse>() {
                public void success(EventResponse result) {
                  wrapped.put("result", result);
                  reply.reply(wrapped);
                }
                public void error(Throwable error) {
                  wrapped.put("error", wrapError(error));
                  reply.reply(wrapped);
                }
              };

              api.onImpression(requestArg, resultCallback);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
              reply.reply(wrapped);
            }
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.YandexAdsApi.onAdClicked", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              EventRequest requestArg = (EventRequest)args.get(0);
              if (requestArg == null) {
                throw new NullPointerException("requestArg unexpectedly null.");
              }
              Result<EventResponse> resultCallback = new Result<EventResponse>() {
                public void success(EventResponse result) {
                  wrapped.put("result", result);
                  reply.reply(wrapped);
                }
                public void error(Throwable error) {
                  wrapped.put("error", wrapError(error));
                  reply.reply(wrapped);
                }
              };

              api.onAdClicked(requestArg, resultCallback);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
              reply.reply(wrapped);
            }
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.YandexAdsApi.onLeftApplication", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              EventRequest requestArg = (EventRequest)args.get(0);
              if (requestArg == null) {
                throw new NullPointerException("requestArg unexpectedly null.");
              }
              Result<EventResponse> resultCallback = new Result<EventResponse>() {
                public void success(EventResponse result) {
                  wrapped.put("result", result);
                  reply.reply(wrapped);
                }
                public void error(Throwable error) {
                  wrapped.put("error", wrapError(error));
                  reply.reply(wrapped);
                }
              };

              api.onLeftApplication(requestArg, resultCallback);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
              reply.reply(wrapped);
            }
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.YandexAdsApi.onReturnedToApplication", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              EventRequest requestArg = (EventRequest)args.get(0);
              if (requestArg == null) {
                throw new NullPointerException("requestArg unexpectedly null.");
              }
              Result<EventResponse> resultCallback = new Result<EventResponse>() {
                public void success(EventResponse result) {
                  wrapped.put("result", result);
                  reply.reply(wrapped);
                }
                public void error(Throwable error) {
                  wrapped.put("error", wrapError(error));
                  reply.reply(wrapped);
                }
              };

              api.onReturnedToApplication(requestArg, resultCallback);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
              reply.reply(wrapped);
            }
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.YandexAdsApi.onAdShown", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              EventRequest requestArg = (EventRequest)args.get(0);
              if (requestArg == null) {
                throw new NullPointerException("requestArg unexpectedly null.");
              }
              Result<EventResponse> resultCallback = new Result<EventResponse>() {
                public void success(EventResponse result) {
                  wrapped.put("result", result);
                  reply.reply(wrapped);
                }
                public void error(Throwable error) {
                  wrapped.put("error", wrapError(error));
                  reply.reply(wrapped);
                }
              };

              api.onAdShown(requestArg, resultCallback);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
              reply.reply(wrapped);
            }
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.YandexAdsApi.onAdDismissed", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              EventRequest requestArg = (EventRequest)args.get(0);
              if (requestArg == null) {
                throw new NullPointerException("requestArg unexpectedly null.");
              }
              Result<EventResponse> resultCallback = new Result<EventResponse>() {
                public void success(EventResponse result) {
                  wrapped.put("result", result);
                  reply.reply(wrapped);
                }
                public void error(Throwable error) {
                  wrapped.put("error", wrapError(error));
                  reply.reply(wrapped);
                }
              };

              api.onAdDismissed(requestArg, resultCallback);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
              reply.reply(wrapped);
            }
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
    }
  }
  private static Map<String, Object> wrapError(Throwable exception) {
    Map<String, Object> errorMap = new HashMap<>();
    errorMap.put("message", exception.toString());
    errorMap.put("code", exception.getClass().getSimpleName());
    errorMap.put("details", "Cause: " + exception.getCause() + ", Stacktrace: " + Log.getStackTraceString(exception));
    return errorMap;
  }
}