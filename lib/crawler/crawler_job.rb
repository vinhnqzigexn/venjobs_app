require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require_relative './helpers'
require 'yaml'
require 'redis'
require 'pry'

$r = Redis.new

print_memory_usage do
  print_time_spent do
    crawler_job
    crawler_city
    crawler_industry
  end
end

def crawler_job
  headers =
    %w[ id
        title
        company_name
        city
        year_experience
        industries
        position
        salary
        update_date
        exp_time
        description
        job_requirements
        job_others
        job_id_careerbuilder
        job_link]

  header_links = %w[id link]

  @id = 0
  page_url = 'https://careerbuilder.vn/viec-lam/tat-ca-viec-lam-vi.html'

  # STEP 1: get link list
  CSV.open('links.csv', 'w', write_headers: true, headers: header_links) do |csv|
    loop do
      page = Nokogiri::HTML(open(page_url))
      page.css('div.gird_standard > dl > dd.brief').each do |row|
        link = row.at_css('span:nth-child(2) > h3.job > a').attributes['href'].value
        puts link
        puts @id
        csv << [@id, link]
        @id += 1
      end

      @btn_res = page.css('div.paginationTwoStatus > a.right')
      break unless @btn_res.any? && @id < 1100
      page_url = @btn_res[0].attributes['href'].value
    end
    # TODO:
    # check if total job # IDsum because sometime server is dump
  end

  # STEP 2: go to get data for each link:
  CSV.open('jobs.csv', 'wb', write_headers: true, headers: headers) do |jobsfile|
    CSV.foreach('links.csv', headers: true) do |link_row|
      data_arr = []
      @url = normalize_uri(link_row['link']).to_s
      next if $r.sismember('visited', @url)
      page = Nokogiri::HTML(open(@url))

      page.css('div.LeftJobCB').each do |object|
        salary = if object.xpath('//*[@id="showScroll"]/ul/li[2]/p[2]/span').text.strip == 'Lương:'
                   object.xpath('//*[@id="showScroll"]/ul/li[2]/p[2]/label')
                         .map(&:children).reject(&:nil?).reject(&:empty?).join(' - ')
                 elsif object.xpath('//*[@id="showScroll"]/ul/li[1]/p[2]/span').text.strip == 'Lương:'
                   object.xpath('//*[@id="showScroll"]/ul/li[1]/p[2]/label')
                         .map(&:children).reject(&:nil?).reject(&:empty?).join(' - ')
                 else
                   'Cạnh tranh'
        end

        industry = if object.xpath('//*[@id="showScroll"]/ul/li[3]/p[1]/span').text.strip == 'Ngành nghề:'
                     object.xpath('//*[@id="showScroll"]/ul/li[3]/p[1]/b/a/text()').text.tr(',', '+')
                   elsif object.xpath('//*[@id="showScroll"]/ul/li[2]/p[1]/span').text.strip == 'Ngành nghề:'
                     object.xpath('//*[@id="showScroll"]/ul/li[2]/p[1]/b/a/text()').text.tr(',', '+')
                   else
                     'Khác'
        end

        job_des_select = object.css('div[class = MarBot20]')
        description = if job_des_select.count == 3
                        object.css('div:nth-child(5) > div.content_fck').text.gsub(/^(.{500,}?).*$/m, '\1...')
                      elsif job_des_select.count == 4
                        object.css('div:nth-child(6) > div.content_fck').text.gsub(/^(.{500,}?).*$/m, '\1...')
                      else
                        'NA'
                        end
        x = object.at_css('div[class = MarBot20]')
        puts "#{link_row['id']} -- #{description.gsub(/^(.{10,}?).*$/m, '\1...')}"
        binding.pry

        data_arr =
          [ # [0] id
            link_row['id'],
            # [1] title
            object.at_css('div.top-job > div.top-job-info > h1').inner_text,
            # [2] company_name
            object.css(' div.box1Detail > p.TitleDetailNew > span').text,
            # [3] city
            object.xpath('//*[@id="showScroll"]/ul/li[1]/p[1]/b/a').text,
            # [4] year_experience
            '',
            # [5] industries
            industry,
            # [6] position
            '',
            # [7] salary
            salary,
            # [8] update_date
            '',
            # [9] exp_time
            '',
            # [10] description
            description,
            # [11] job_requirements
            '',
            # [12] job_others
            '',
            # [13] job_id_careerbuilder
            '',
            # [14] job_link
            @url
          ]

        $r.sadd('crawled', YAML.dump(data_arr))
        $r.sadd('visited', @url)
      end
    end
  end
end

def crawler_city
  page_url = 'https://careerbuilder.vn/viec-lam/tat-ca-viec-lam-vi.html'
  page = Nokogiri::HTML(open(page_url))
  cities = page.xpath('//*[@id="location"]')

  cities[0].children.each do |city, _id|
    code = city['value'].scan(/\s?\-?\d+/).first
    slug = code == '-1' ? 'tat-ca-dia-diem' : city['value'].scan(/[[a-z]|\-]+/).first
    name = city.children.first.content.strip
    $r.sadd('cities', YAML.dump([code, name, slug]))
  end
end

def crawler_industry
  page_url = 'https://careerbuilder.vn/viec-lam/tat-ca-viec-lam-vi.html'
  page = Nokogiri::HTML(open(page_url))
  inds = page.xpath('//*[@id="industry"]')

  inds[0].children.each do |ind|
    code = ind['value'].scan(/\s?\-?\d+/).first
    slug = code == '-1' ? 'tat-ca-nganh-nghe' : ind['value'].scan(/[[a-z]|\-]+/).first
    name = ind.children.first.content
    $r.sadd('industry', YAML.dump([code, name, slug]))
  end
end

# convert to uri standard if any non ASCII character
def normalize_uri(uri)
  return uri if uri.is_a? URI

  uri = uri.to_s
  uri, *tail = uri.rpartition '#' if uri['#']

  URI(URI.encode(uri) << Array(tail).join)
end
