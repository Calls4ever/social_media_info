require 'timeout'


class SocialMediaDetailController <ApplicationController
    def index 
         
        if SocialMediaDetail.all.empty? 
            result =get_result()
            render_result(result)
        else
            result = SocialMediaDetail.last
            # render_result(result)
            begin
                Timeout.timeout(0.5) do
                result = get_result()
                end
            rescue Timeout::Error
                render_result(result)
                SocialMediaDetail.last.destroy
            end
            # result = get_result()
         end
        
    end


    def render_result(result)
        tweets = []
        result.twitters.each{|twitter| tweets.push(twitter.tweet)}
        statuses = []
        result.facebooks.each{|facebook| statuses.push(facebook.status)}
        render json: {twitter: tweets, facebook: statuses}
        # render json: result, include: [:twitters, :facebooks]
    end

    def get_result
        social_media_detail = SocialMediaDetail.create()  
        twitters=get_social_media_info("twitter")
        facebooks=get_social_media_info("facebook")
        while(twitters.empty?)do
            twitters = get_social_media_info("twitter")
        end
        while(facebooks.empty?)do
            facebooks = get_social_media_info("facebook")
        end
        social_media_detail.twitters =twitters
        social_media_detail.facebooks = facebooks

        return social_media_detail

    end


    def get_social_media_info(type)
        uri = URI("https://takehome.io/#{type}")
        response = Net::HTTP.get_response(uri)
        elements = []
        if(response.is_a?(Net::HTTPSuccess))
           if(response.body[0]=="[")
                result = JSON.parse(response.body) 
                if(type=="twitter")
                    for ele in result do
                        elements.push(Twitter.create(tweet: ele["tweet"]))
                    end
                else
                    for ele in result do
                        elements.push(Facebook.create(status: ele["status"]))
                    end
                end
                
           end
        end
        return elements
    end

    def timed_social_media_info_call(type)
        api_result = "delayed"
        intial_time = DateTime.now.strftime("%Q")
        current_time = DateTime.now.strftime("%Q")
        while((current_time.to_i-intial_time.to_i)<200)do
            current_time = DateTime.now.strftime("%Q")
            api_result = get_social_media_info(type)
        end
        return api_result
    end
end